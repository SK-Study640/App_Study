class Typing::Progress < ApplicationRecord
  belongs_to :user, foreign_key: : user_id
  belongs_to :sentence, foreign_key: :sentence_id

  # 現在の最新の途中経過を取得する
  def current_progress(game_id)
    Typing::Progress.where(game_id: game_id).order(success_count: :asc).first
  end
end
