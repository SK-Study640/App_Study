# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :result, dependent: :destroy, class_name: 'Typing::Result'
  enum role: { general: 0, admin: 1 }

  # 順位計算時のデフォルト加算値
  DEFAULT_RANK_INCREMENT = 1

  # 最速タイム（最高タイム）を取得するインスタンスメソッド
  def typing_best_time
    Typing::Result.where(user: self).order(time: :asc).first&.time
  end

  # 指定されたユーザーの最速タイム（最高タイム）を取得するインスタンスメソッド
  def typing_rank
    best_time = typing_best_time
    return nil unless best_time

    # 自身より良いタイムの数+1を自身の順位とする
    Typing::Result.where('time < ?', best_time).count + DEFAULT_RANK_INCREMENT
  end
end
