class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update ]
  before_action :admin_user

  def index
    @users = User.all
  end

  def edit
  end

  def update
      user_params_filtered = user_params.reject { |k, v| v.blank? } # 空の値は更新対象から除外
    if @user.update(user_params_filtered)
        redirect_to admin_users_path, notice: "ユーザー情報を更新しました"
    else
      render "edit"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
