# frozen_string_literal: true

module Typing
  # ゲームIDを保持するモデル
  class Game < ApplicationRecord
    belongs_to :user
    

    # ゲームIDを作成して、作成したIDを返すクラスメソッド
    # 作成に失敗した場合は例外に投げる
    def self.create_game_id(user_id)
      game = Typing::Game.new(user_id:)
      raise 'ゲーム開始に失敗しました' unless game.save

      Typing::Game.where(user_id:).order(id: :desc).first&.id
    end

    # 現在の最新の途中経過を取得するクラスメソッド
    def get_current_progress
      Typing::Progress.where(game_id: id).order(id: :desc).first
    end

    # 対象ゲームの経過時間を返すクラスメソッド
    def get_elapsed_time
      elapsed_time = 0
      elapsed_times = Typing::Progress.where(game_id: id).pluck(:elapsed_time)
      elapsed_times.each do |i|
        elapsed_time += i
      end
      elapsed_time
    end

    # 対象ゲームの成功数を返すクラスメソッド
    def get_success_count
      Typing::Progress.where(game_id: id, is_success: true).count
    end
  end
end
