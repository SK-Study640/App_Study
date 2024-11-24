class Typing::GameId < ApplicationRecord
  belongs_to :user, foreign_key: :user_id

  # ゲームIDを作成して、作成したIDを返す
  # 作成に失敗した場合は例外に投げる
  def create_game_id(user_id)
    game_id = Typing::GameId.new(user_id: user_id)
    if game_id.save
      return Typing::GameId.where(user_id: user_id).order(id: desc).first&.game_id
    
    else
      raise "ゲーム開始に失敗しました"
    end
  end
end
