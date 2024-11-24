class TypingController < ApplicationController
  require "time"
  INCREMENT_SUCCESS_AND_ERROR_COUNT = 1

  def home
    @results = Typing::Result.order(time: :asc)
  end

  def start
    session[:game_id] = Typing::Game.create_game_id(current_user.id)
    redirect_to action: :play
  end

  def play
    game_id = Typing::Game.find_by(id: session[:game_id])
    # nilチェックを追加（該当するレコードがない場合の対応）
    if game_id.nil?
      flash[:error] = "ゲーム開始に失敗しました"
      redirect_to root_path and return
    end

    session[:start_time] = Time.now.iso8601
    @sentence = Typing::Sentence.order("RANDOM()").first
    @elapsed_time = game_id.get_elapsed_time
    @current_progress = game_id.get_current_progress
    if @current_progress.nil?
      @correct_count = 0
    else
      @correct_count = @current_progress.success_count
    end
  end

  def check_answer
    @sentence = Typing::Sentence.find(params[:sentence_id])
    game_id = Typing::Game.find_by(id: session[:game_id])

    @current_progress = Typing::Progress.initialize_progress(game_id: session[:game_id], user_id: current_user.id, sentence_id: @sentence.id, elapsed_time: Time.now - Time.iso8601(session[:start_time]))
    # 現在の途中結果を取得する
    @previouse_progress = game_id.get_current_progress
    if !@previouse_progress.nil?
      @current_progress.success_count = @previouse_progress.success_count
      @current_progress.error_count = @previouse_progress.error_count
    end

    if @sentence.content == params[:user_input]
      # 正解の場合
      @current_progress.success_count += INCREMENT_SUCCESS_AND_ERROR_COUNT
      flash[:typing_notice] = "正解です"

    else
      # 不正解の場合
      @current_progress.error_count += INCREMENT_SUCCESS_AND_ERROR_COUNT
      flash[:typing_alert] = "不正解です"
    end
    @current_progress.save!

    #  10回以上正解したら結果画面へ
    if @current_progress.success_count >= 10
      redirect_to action: :result
      return

    end
    redirect_to action: :play
  end

  def result
    game = Typing::Game.find_by(id: session[:game_id])
    @elapsed_time = game.get_elapsed_time
    if Typing::Result.create_or_update(current_user, @elapsed_time)
      flash[:typing_notice] = "ベストタイムを更新しました"
    else
      flash[:typing_notice] = "タイムは更新されませんでした"
    end
    @user_best_time = current_user.typing_best_time
    @user_rank = current_user.typing_rank
  end
end
