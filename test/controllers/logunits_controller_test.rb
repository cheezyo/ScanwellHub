require 'test_helper'

class LogunitsControllerTest < ActionController::TestCase
  setup do
    @logunit = logunits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logunits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logunit" do
    assert_difference('Logunit.count') do
      post :create, logunit: { arrive_date: @logunit.arrive_date, recived_by: @logunit.recived_by, send_date: @logunit.send_date, sent_by: @logunit.sent_by, sent_from: @logunit.sent_from, sent_to: @logunit.sent_to, status: @logunit.status, unit_id: @logunit.unit_id }
    end

    assert_redirected_to logunit_path(assigns(:logunit))
  end

  test "should show logunit" do
    get :show, id: @logunit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logunit
    assert_response :success
  end

  test "should update logunit" do
    patch :update, id: @logunit, logunit: { arrive_date: @logunit.arrive_date, recived_by: @logunit.recived_by, send_date: @logunit.send_date, sent_by: @logunit.sent_by, sent_from: @logunit.sent_from, sent_to: @logunit.sent_to, status: @logunit.status, unit_id: @logunit.unit_id }
    assert_redirected_to logunit_path(assigns(:logunit))
  end

  test "should destroy logunit" do
    assert_difference('Logunit.count', -1) do
      delete :destroy, id: @logunit
    end

    assert_redirected_to logunits_path
  end
end
