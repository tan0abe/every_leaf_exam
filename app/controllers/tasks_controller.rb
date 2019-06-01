class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.page(params[:page]).per(3).order('deadline DESC')
    elsif params[:sort_priority]
      @tasks = Task.page(params[:page]).per(3).order('priority DESC')
    else
      @tasks = Task.page(params[:page]).per(3).order('created_at DESC')
    end

    if params[:task]
      if params[:task][:title] && params[:task][:status]
        @tasks = Task.page(params[:page]).per(3).search_title(params[:task][:title]).search_status(params[:task][:status])
      elsif params[:task][:title]
        @tasks = Task.page(params[:page]).per(3).search_title(params[:task][:title])
      else params[:task][:status]
        @tasks = Task.page(params[:page]).per(3).search_status(params[:task][:status])
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
