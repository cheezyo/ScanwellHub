require 'test_helper'

class UnitTodosControllerTest < ActionController::TestCase
  setup do
    @unit_todo = unit_todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unit_todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unit_todo" do
    assert_difference('UnitTodo.count') do
      post :create, unit_todo: { level: @unit_todo.level, task: @unit_todo.task, todo_id: @unit_todo.todo_id }
    end

    assert_redirected_to unit_todo_path(assigns(:unit_todo))
  end

  test "should show unit_todo" do
    get :show, id: @unit_todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unit_todo
    assert_response :success
  end

  test "should update unit_todo" do
    patch :update, id: @unit_todo, unit_todo: { level: @unit_todo.level, task: @unit_todo.task, todo_id: @unit_todo.todo_id }
    assert_redirected_to unit_todo_path(assigns(:unit_todo))
  end

  test "should destroy unit_todo" do
    assert_difference('UnitTodo.count', -1) do
      delete :destroy, id: @unit_todo
    end

    assert_redirected_to unit_todos_path
  end
end
