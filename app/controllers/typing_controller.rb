# frozen_string_literal: true

class TypingController < ApplicationController
  require 'time'
  INCREMENT_SUCCESS_AND_ERROR_COUNT = 1

  def home
    @results = Typing::Result.order(time: :asc)
  end

  def start
    game_id = Typing::Game.create_game_id(current_user.id)
    redirect_to typing_play_path(game_id)
  end

  def play
    @game = Typing::Game.find_by(id: params[:game_id])
    # nilチェックを追加（該当するレコードがない場合の対応）
    if @game.nil?
      flash[:error] = 'ゲーム開始に失敗しました'
      redirect_to root_path and return
    end

    session[:start_time] = Time.now.iso8601
    @sentence = Typing::Sentence.order('RANDOM()').first
    @elapsed_time = @game.get_elapsed_time
    @current_progress = @game.get_current_progress
    @correct_count = @game.get_success_count
  end

  def check_answer
    @sentence = Typing::Sentence.find(params[:sentence_id])
    @game = Typing::Game.find_by(id: params[:game_id])
    success_count = @game.get_success_count

    @current_progress = Typing::Progress.initialize_progress(game_id: @game.id, user_id: current_user.id,
                                                             sentence_id: @sentence.id, elapsed_time: Time.zone.now - Time.iso8601(session[:start_time]))

    if @sentence.content == params[:user_input]
      # 正解の場合
      @current_progress.is_success = true
      success_count += INCREMENT_SUCCESS_AND_ERROR_COUNT
      flash[:typing_notice] = '正解です'

    else
      # 不正解の場合
      flash[:typing_alert] = '不正解です'
    end
    @current_progress.save!

    #  10回以上正解したら結果画面へ
    if success_count >= 10
      redirect_to typing_result_path(@game.id)
      return

    end
    redirect_to typing_play_path(@game.id)
  end

  def result
    @game = Typing::Game.find_by(id: params[:game_id])
    @elapsed_time = @game.get_elapsed_time
    Typing::Result.create!(time: @elapsed_time, user_id: current_user.id)
    @user_best_time = current_user.result.order(time: :asc).first&.time
    flash[:typing_notice] = if @elapsed_time == @user_best_time
                              'ベストタイムを更新しました'
                            else
                              'タイムは更新されませんでした'
                            end
    # 自身の結果秒数よりも良い結果の数+1を自身の順位とする
    @user_rank = Typing::Result.where(time: @user_best_time).count + 1
  end
end
