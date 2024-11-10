class Typing::Result < ApplicationRecord
  belongs_to :user

  def self.create_or_update(user, new_time)
    best_result = Typing::Result.where(user: user).order(time: :asc).first
    # ユーザーの結果がないか、新しいタイムが既存のタイムよりも速い場合は更新
    if best_result.nil? || new_time < best_result.time
      result = Typing::Result.new(user: user)
      result.time = new_time
      result.save!
    else
      false
    end
  end
end