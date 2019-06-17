class Admin::UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user.id), notice: "ユーザー登録が完了しました"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    
  end

  def destroy
    
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
