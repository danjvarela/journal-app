require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = users :one
  end

  test "should not save when name is empty" do
    category = Category.new user: @user
    assert_not category.save
  end

  test "name should be atleast 5 characters long" do
    category = Category.new name: "aaa", user: @user
    assert_not category.save
  end
end
