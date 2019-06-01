class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(deadline: :desc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:task]
      if params[:task][:title] && params[:task][:status]
        # @tasks = Task.search_title_status(params[:task][:title][:status])
        @tasks = Task.search_title(params[:task][:title]).search_status(params[:task][:status])
      elsif params[:task][:title]
        @tasks = Task.search_title(params[:task][:title])
      else params[:task][:status]
        @tasks = Task.search_status(params[:task][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "タスクを作成しました"
      redirect_to task_path(@task.id)
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
      flash[:success] = "タスクを更新しました"
      redirect_to tasks_path
    else
      flash.now[:danger] = "タスクを更新できませんでした"
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:danger] = "タスクを削除しました"
    redirect_to tasks_path

  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :priority, :status, :deadline)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
