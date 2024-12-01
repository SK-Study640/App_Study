# frozen_string_literal: true

module Typing
  # ゲームの進捗度を保持するモデル
  # Association
  # - belongs_to :game
  # - belongs_to :user
  # - belongs_to :sentence
  class Progress < ApplicationRecord
    belongs_to :game
    belongs_to :user
    belongs_to :sentence

    # 初期化メソッド
    def self.initialize_progress(game_id:, user_id:, sentence_id:, elapsed_time:)
      new(
        game_id:,
        elapsed_time:,
        user_id:,
        sentence_id:,
        is_success: false
      )
    end
  end
end
