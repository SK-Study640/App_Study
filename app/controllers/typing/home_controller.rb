class Typing::HomeController < ApplicationController
  def home
    @results = Typing::Result.order(time: :asc)
  end

  def play
    # 初期化（1回目アクセス時）
    session[:correct_count] ||= 0
    session[:start_time] ||= Time.now

    # 経過時間の計算
    @elapsed_time = Time.now - Time.parse(session[:start_time].to_s)

    # 正解回数のチェック（10回に達したら終了画面へ）
    if session[:correct_count] >= 10
      redirect_to game_finished_path
    else
      # 次の問題文を生成（またはDBから取得）
      @sentence = Typing::Sentence.order("RANDOM()").first
    end
  end

  def submit_answer
    @sentence = Typing::Sentence.order("RANDOM()").first
    if params[:answer] == @sentence.content
      session[:correct_count] += 1
    end

    # 次の問題を表示するために再度playアクションへリダイレクト
    redirect_to game_play_path
  end

  def finished
    # 経過時間と正解回数のリセット
    session[:correct_count] = 0
    session[:start_time] = nil
  end
end
