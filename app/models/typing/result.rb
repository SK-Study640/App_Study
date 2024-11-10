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

  # 指定されたユーザーの最速タイム（最高タイム）を取得するクラスメソッド
  # @param user [User] タイムを取得する対象のユーザー
  # @return [Float, nil] ユーザーの最速タイムがあればそのタイム、なければnil
  def self.user_best_time(user)
    Typing::Result.where(user: user).order(time: :asc).first&.time
  end

  # 指定されたユーザーのランキングを取得するクラスメソッド
  # @param user [User] ランキングを取得する対象のユーザー
  # @return [Integer, nil] ユーザーのランキングが計算できればその順位、ユーザーに結果がない場合はnil
  def self.user_rank(user)
    best_time = user_best_time(user)
    return nil unless best_time
    Typing::Result.where("time < ?", best_time).count + 1
  end
end