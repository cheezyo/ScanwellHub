require 'test_helper'

class CompTodosControllerTest < ActionController::TestCase
  setup do
    @comp_todo = comp_todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comp_todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comp_todo" do
    assert_difference('CompTodo.count') do
      post :create, comp_todo: { level: @comp_todo.level, task: @comp_todo.task, todo_id: @comp_todo.todo_id }
    end

    assert_redirected_to comp_todo_path(assigns(:comp_todo))
  end

  test "should show comp_todo" do
    get :show, id: @comp_todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comp_todo
    assert_response :success
  end

  test "should update comp_todo" do
    patch :update, id: @comp_todo, comp_todo: { level: @comp_todo.level, task: @comp_todo.task, todo_id: @comp_todo.todo_id }
    assert_redirected_to comp_todo_path(assigns(:comp_todo))
  end

  test "should destroy comp_todo" do
    assert_difference('CompTodo.count', -1) do
      delete :destroy, id: @comp_todo
    end

    assert_redirected_to comp_todos_path
  end
end
