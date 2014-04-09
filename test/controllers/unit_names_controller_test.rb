require 'test_helper'

class UnitNamesControllerTest < ActionController::TestCase
  setup do
    @unit_name = unit_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_name" do
    assert_difference('UnitName.count') do
      post :create, unit_name: { description: @unit_name.description, title: @unit_name.title }
    end

    assert_redirected_to unit_name_path(assigns(:unit_name))
  end

  test "should show unit_name" do
    get :show, id: @unit_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_name
    assert_response :success
  end

  test "should update unit_name" do
    patch :update, id: @unit_name, unit_name: { description: @unit_name.description, title: @unit_name.title }
    assert_redirected_to unit_name_path(assigns(:unit_name))
  end

  test "should destroy unit_name" do
    assert_difference('UnitName.count', -1) do
      delete :destroy, id: @unit_name
    end

    assert_redirected_to unit_names_path
  end
end
