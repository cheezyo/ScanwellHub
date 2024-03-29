require 'test_helper'

class ComponentsControllerTest < ActionController::TestCase
  setup do
    @component = components(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:components)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create component" do
    assert_difference('Component.count') do
      post :create, component: { available: @component.available, calibrated: @component.calibrated, commet: @component.commet, comp_id: @component.comp_id, last_check: @component.last_check, type_id: @component.type_id, unit_id: @component.unit_id }
    end

    assert_redirected_to component_path(assigns(:component))
  end

  test "should show component" do
    get :show, id: @component
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @component
    assert_response :success
  end

  test "should update component" do
    patch :update, id: @component, component: { available: @component.available, calibrated: @component.calibrated, commet: @component.commet, comp_id: @component.comp_id, last_check: @component.last_check, type_id: @component.type_id, unit_id: @component.unit_id }
    assert_redirected_to component_path(assigns(:component))
  end

  test "should destroy component" do
    assert_difference('Component.count', -1) do
      delete :destroy, id: @component
    end

    assert_redirected_to components_path
  end
end
