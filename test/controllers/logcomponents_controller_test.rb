require 'test_helper'

class LogcomponentsControllerTest < ActionController::TestCase
  setup do
    @logcomponent = logcomponents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logcomponents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logcomponent" do
    assert_difference('Logcomponent.count') do
      post :create, logcomponent: { arrive_date: @logcomponent.arrive_date, comp_id: @logcomponent.comp_id, on_unit: @logcomponent.on_unit, recived_by: @logcomponent.recived_by, send_date: @logcomponent.send_date, sent_by: @logcomponent.sent_by, sent_from: @logcomponent.sent_from, sent_to: @logcomponent.sent_to, status: @logcomponent.status }
    end

    assert_redirected_to logcomponent_path(assigns(:logcomponent))
  end

  test "should show logcomponent" do
    get :show, id: @logcomponent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logcomponent
    assert_response :success
  end

  test "should update logcomponent" do
    patch :update, id: @logcomponent, logcomponent: { arrive_date: @logcomponent.arrive_date, comp_id: @logcomponent.comp_id, on_unit: @logcomponent.on_unit, recived_by: @logcomponent.recived_by, send_date: @logcomponent.send_date, sent_by: @logcomponent.sent_by, sent_from: @logcomponent.sent_from, sent_to: @logcomponent.sent_to, status: @logcomponent.status }
    assert_redirected_to logcomponent_path(assigns(:logcomponent))
  end

  test "should destroy logcomponent" do
    assert_difference('Logcomponent.count', -1) do
      delete :destroy, id: @logcomponent
    end

    assert_redirected_to logcomponents_path
  end
end
