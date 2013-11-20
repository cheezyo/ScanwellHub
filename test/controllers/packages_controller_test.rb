require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  setup do
    @package = packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create package" do
    assert_difference('Package.count') do
      post :create, package: { arrival_date: @package.arrival_date, coment: @package.coment, components_ids: @package.components_ids, destiantion: @package.destiantion, origin: @package.origin, pack_nr: @package.pack_nr, po: @package.po, reciver: @package.reciver, ref: @package.ref, status: @package.status, unit_ids: @package.unit_ids }
    end

    assert_redirected_to package_path(assigns(:package))
  end

  test "should show package" do
    get :show, id: @package
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @package
    assert_response :success
  end

  test "should update package" do
    patch :update, id: @package, package: { arrival_date: @package.arrival_date, coment: @package.coment, components_ids: @package.components_ids, destiantion: @package.destiantion, origin: @package.origin, pack_nr: @package.pack_nr, po: @package.po, reciver: @package.reciver, ref: @package.ref, status: @package.status, unit_ids: @package.unit_ids }
    assert_redirected_to package_path(assigns(:package))
  end

  test "should destroy package" do
    assert_difference('Package.count', -1) do
      delete :destroy, id: @package
    end

    assert_redirected_to packages_path
  end
end
