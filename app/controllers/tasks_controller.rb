class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "投稿しました"
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "更新しました"
      redirect_to tasks_path
    else
      flash.now[:danger] = "更新できませんでした"
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:danger] = "削除しました"
    redirect_to tasks_path

  end

  private

  def task_params
    params.require(:task).permit(:title, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
