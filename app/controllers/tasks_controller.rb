class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @category.tasks.order(deadline: :asc)
  end

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build task_params.merge {user: current_user}
    if @task.save
      redirect_to category_tasks_path(@category), success: "Task created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update task_params
      redirect_to category_tasks_path(@category), success: "Task updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@category), success: "Task deleted successfully"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :category_id, :deadline)
  end

  def get_task
    @task = Task.find params[:id]
  end

  def get_category
    @category = Category.find params[:category_id]
  end
end
