class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user, only: [:show]
  before_action :forbid_login_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      flash[:notice] = "ユーザー登録しました"
    else
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
