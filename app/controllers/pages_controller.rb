class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @categories = Category.where user: current_user
    tasks = Task.for_today
    @tasks_for_today = tasks.select { |task| task.user_id == current_user.id }.sort_by { |task| task.deadline }
  end

  def tasks
    @categories = Category.where user: current_user
    @tasks_by_deadline = {}

    Task.group_by_deadline.each do |deadline, tasks|
      current_user_tasks = tasks.select { |task| task.user_id == current_user.id }.sort_by { |task| task.deadline }
      @tasks_by_deadline[deadline] = current_user_tasks if !current_user_tasks.empty?
    end
  end
end
