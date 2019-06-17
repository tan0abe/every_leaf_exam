class Admin::UsersController < ApplicationController
  def index
  end

  def new
  end

  def create

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

  def admin_required
    unless current_user.admin?
      redirect_to root_path, notice: "権限がありません"
    end
  end
end
