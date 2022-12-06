require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @category = categories :one
  end

  test "should not save when name is empty" do
    task = @category.tasks.build description: "sample description"
    assert_not task.save
  end

  test "name should be atleast 5 characters long" do
    task = @category.tasks.build description: "sample description", name: "aaa"
    assert_not task.save
  end

  test "deadline should be a past date" do
    task = @category.tasks.build description: "sample description", name: "sample name", deadline: 7.days.ago
    assert_not task.save
  end
end
