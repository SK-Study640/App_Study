class Typing::Game < ApplicationRecord
  belongs_to :user, foreign_key: :user_id

  # ゲームIDを作成して、作成したIDを返すクラスメソッド
  # 作成に失敗した場合は例外に投げる
  def self.create_game_id(user_id)
    game = Typing::Game.new(user_id: user_id)
    if game.save
      Typing::Game.where(user_id: user_id).order(id: :desc).first&.id

    else
      raise "ゲーム開始に失敗しました"
    end
  end

    # 現在の最新の途中経過を取得するクラスメソッド
    def get_current_progress
      Typing::Progress.where(game_id: self.id).order(id: :desc).first
    end

    # 対象ゲームの経過時間を返すクラスメソッド
    def get_elapsed_time
      elapsed_time = 0
      elapsed_times = Typing::Progress.where(game_id: self.id).pluck(:elapsed_time)
      for i in elapsed_times do
        elapsed_time += i
      end
      elapsed_time
    end

    # 対象ゲームの成功数を返すクラスメソッド
    def get_success_count
      Typing::Progress.where(game_id: self.id, is_success: true).count()
    end
end