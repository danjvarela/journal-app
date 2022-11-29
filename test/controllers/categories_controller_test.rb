require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    get new_category_path
    assert_response :success
  end

  test "should post create" do
    category = Category.new name: "sample name"
    post categories_path, params: {category: category.attributes}
    assert_response :redirect
  end

  test "should get edit" do
    category = Category.create name: "sample category"
    get edit_category_path category
    assert_response :success
  end

  test "should put/patch update" do
    category = Category.create name: "sample category"
    new_category = Category.new name: "new sample name"
    put category_path category, params: {category: new_category.attributes}
    assert_response :redirect
    patch category_path category, params: {category: new_category.attributes}
    assert_response :redirect
  end

  test "should get show" do
    category = Category.create name: "sample category"
    get category_path category
    assert_response :success
  end

  test "should delete destroy" do
    category = Category.create name: "sample category"
    delete category_path category
    assert_response :redirect
  end
end
