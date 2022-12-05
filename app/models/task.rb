class Task < ApplicationRecord
  DATE_FORMAT = "%B %e, %Y"
  belongs_to :category
  validates :name, presence: true, length: {minimum: 5}
  validate :deadline_not_in_the_past

  # returns an array of all the tasks grouped into days
  def self.group_per_deadline
    all.order(deadline: :asc).each_with_object({}) do |task, days|
      day = task.formatted_deadline

      if days[day]
        days[day].push task
      else
        days[day] = [task]
      end
    end
  end

  def deadline_today?
    (Time.now.beginning_of_day..Time.now.end_of_day).cover? deadline
  end

  def formatted_deadline(format = nil)
    return deadline.strftime format if format

    return "no_deadline" if deadline.blank?
    return "today" if deadline_today?
    deadline.strftime DATE_FORMAT
  end

  private

  def deadline_not_in_the_past
    return if deadline.blank?

    if deadline < Time.now
      errors.add(:deadline, "cannot be a date in the past")
    end
  end
end
