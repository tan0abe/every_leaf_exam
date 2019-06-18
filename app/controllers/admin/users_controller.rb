class Admin::UsersController < ApplicationController
  before_action :admin_required
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  PER = 10

  def index
    @users = User.page(params[:page]).per(PER)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user.id), notice: "ユーザー【#{@user.name}】を登録しました"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー【#{@user.name}】を更新しました"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー【#{@user.name}】を削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_required
    unless current_user.admin?
      redirect_to root_path, notice: "権限がありません"
    end
  end
end
