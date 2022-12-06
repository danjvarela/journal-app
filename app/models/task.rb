class Task < ApplicationRecord
  DATE_FORMAT = "%B %e, %Y"
  TIME_FORMAT = "%l:%M %p"
  belongs_to :category
  belongs_to :user
  validates :name, presence: true, length: {minimum: 5}
  validate :deadline_not_in_the_past

  def self.group_by_deadline
    all.order(deadline: :asc).each_with_object({}) do |task, group|
      deadline_day = task.deadline_today? ? "Due today" : task.formatted_deadline

      if group[deadline_day]
        group[deadline_day].push task
      else
        group[deadline_day] = [task]
      end
    end
  end

  def deadline_in_the_past?
    deadline < Time.zone.now
  end

  def deadline_today?
    (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).cover? deadline
  end

  def deadline_tomorrow?
    (Time.zone.tomorrow.beginning_of_day..Time.zone.tomorrow.end_of_day).cover? deadline
  end

  def self.for_today
    Task.where(deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(deadline: :asc)
  end

  def format_deadline
    return "" if deadline.blank?
    deadline.strftime("#{DATE_FORMAT} #{TIME_FORMAT}")
  end

  def formatted_deadline
    return "No due date" if deadline.blank?
    return "Overdue" if deadline_in_the_past?
    return "Due #{deadline.strftime(TIME_FORMAT)}" if deadline_today?
    return "Due tomorrow" if deadline_tomorrow?
    "Due on #{deadline.strftime(DATE_FORMAT).capitalize}"
  end

  private

  def deadline_not_in_the_past
    return if deadline.blank?

    if deadline_in_the_past?
      errors.add(:deadline, "cannot be a date in the past")
    end
  end
end
