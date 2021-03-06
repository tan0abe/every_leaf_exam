class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :enssure_correct_user_for_task, only: [:show, :edit, :update, :destroy]

  def index
    # ソート機能
    if params[:sort_expired]
      # @tasks = Task.page(params[:page]).per(3).order('deadline ASC')
      @tasks = current_user.tasks.page(params[:page]).per(3).order('deadline ASC')
    elsif params[:sort_priority]
      # @tasks = Task.page(params[:page]).per(3).order('priority DESC')
      @tasks = current_user.tasks.page(params[:page]).per(3).order('priority DESC')
    else
      # @tasks = Task.page(params[:page]).per(3).order('created_at DESC')
      @tasks = current_user.tasks.page(params[:page]).per(3).order('created_at DESC')
    end
    # 検索機能
    if params[:task]
      if params[:task][:title] && params[:task][:status]
        # @tasks = Task.page(params[:page]).per(3).search_title(params[:task][:title]).search_status(params[:task][:status])
        @tasks = current_user.tasks.page(params[:page]).per(3).search_title(params[:task][:title]).search_status(params[:task][:status])
      elsif params[:task][:title]
        # @tasks = Task.page(params[:page]).per(3).search_title(params[:task][:title])
        @tasks = current_user.tasks.page(params[:page]).per(3).search_title(params[:task][:title])
      else params[:task][:status]
        # @tasks = Task.page(params[:page]).per(3).search_status(params[:task][:status])
        @tasks = current_user.tasks.page(params[:page]).per(3).search_status(params[:task][:status])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)  #ログイン中のユーザーのidを渡す
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
    # @task = Task.find(params[:id])
    @task = current_user.tasks.find(params[:id])
  end

  #ログインしているユーザーのみタスク管理が出来るようにする
  def enssure_correct_user_for_task
    @task = Task.find(params[:id])
    unless current_user.id == @task.user_id
      redirect_to tasks_path, notice: "権限がありません"
    end
  end
end
