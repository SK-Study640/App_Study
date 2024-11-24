class Typing::Progress < ApplicationRecord
  belongs_to :game, foreign_key: :game_id
  belongs_to :user, foreign_key: :user_id
  belongs_to :sentence, foreign_key: :sentence_id

  # 初期化メソッド
  def self.initialize_progress(game_id:, user_id:, sentence_id:, elapsed_time:)
    new(
      game_id: game_id,
      elapsed_time: elapsed_time,
      user_id: user_id,
      sentence_id: sentence_id,
      is_success: false
    )
  end
end
