class TypingController < ApplicationController
  require 'time'
  def home
    @results = Typing::Result.order(time: :asc)
  end

  def start
    session[:start_time] = Time.now
    session[:correct_count] = 0
    redirect_to action: :play
  end

  def play
    @sentence = Typing::Sentence.order("RANDOM()").first
    @elapsed_time = Time.at(Time.now - Time.parse(session[:start_time])).to_i
    @correct_count = session[:correct_count]
  end

  def check_answer
    @sentence = Typing::Sentence.find(params[:sentence_id])
    @user_input = params[:user_input]
    @correct_count = session[:correct_count] || 0

    if @sentence.content == @user_input
      # 正解の場合
      session[:correct_count] = @correct_count + 1
      flash[:typing_notice] = "正解です"
      #  10回以上正解したら結果画面へ
      if session[:correct_count] >= 10
        redirect_to action: :result
        return
      end
    else
      # 不正解の場合
      flash[:typing_alert] = "不正解です"
    end
    redirect_to action: :play
  end

  def result
    @elapsed_time = Time.at(Time.now - Time.parse(session[:start_time])).to_i
    if Typing::Result.create_or_update(current_user, @elapsed_time)
      flash[:typing_notice] = "ベストタイムを更新しました"
    else
      flash[:typing_notice] = "タイムは更新されませんでした"
    end
  end
end
