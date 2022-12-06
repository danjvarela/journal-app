class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @categories = Category.where user: current_user
    tasks = Task.all
    @tasks_for_today = tasks.select { |task| task.user_id == current_user.id }.sort_by { |task| task.deadline }
  end
end
