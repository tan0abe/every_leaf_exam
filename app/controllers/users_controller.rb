class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user, only: [:show]
  before_action :forbid_login_user, only: [:new, :create]
  before_action :enssure_correct_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    if current_user.present?  #ログインしていない時は、current_user.idを確かめないので、current_userがnilというエラーにならない
      unless current_user.id == @user.id
        flash[:danger] = "他人のプロフィールは見ることはできません！"
        redirect_to tasks_path
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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
