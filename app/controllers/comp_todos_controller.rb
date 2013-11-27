class CompTodosController < ApplicationController
  before_action :set_comp_todo, only: [:show, :edit, :update, :destroy]
  helper_method :get_comp_todo
  # GET /comp_todos
  # GET /comp_todos.json
  def index
    @comp_todos = CompTodo.all
  end

  # GET /comp_todos/1
  # GET /comp_todos/1.json
  def show
  end

  # GET /comp_todos/new
  def new
    @comp_todo = CompTodo.new
    @comp_id = params[:comp_id].to_i
  end

  # GET /comp_todos/1/edit
  def edit
  end
  def task_done
    get_comp_todo
    @todo.update({done: true})
    #Todo.update_all({done: true}, {id: params[:todo_ids]})
    redirect_to component_path(@comp_todo.component_id), notice: 'Task is done'
  end
  
  def undo_task
    get_comp_todo
    @todo.update({done: false})
    redirect_to component_path(@comp_todo.component_id), notice: 'Task is un-done'
  end
  # POST /comp_todos
  # POST /comp_todos.json
  def create
    @comp_todo = CompTodo.new(comp_todo_params)

    respond_to do |format|
      if @comp_todo.save
        format.html { redirect_to component_path(@comp_todo.component_id), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comp_todo }
      else
        format.html { redirect_to component_path(@comp_todo.component_id), alert: 'Task was not created please fill inn all the fields when making a task.' }
        format.json { render json: @comp_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_todos/1
  # PATCH/PUT /comp_todos/1.json
  def update
    respond_to do |format|
      if @comp_todo.update(comp_todo_params)
        format.html { redirect_to @comp_todo, notice: 'Task was updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comp_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comp_todos/1
  # DELETE /comp_todos/1.json
  def destroy
    @comp_todo.destroy
    respond_to do |format|
      format.html { redirect_to component_path(@comp_todo.component), notice: "Task was deleted" }
      format.json { head :no_content }
    end
  end

  private
  def get_comp_todo
    @todo = Todo.find(params[:todo_id])
    @comp_todo = CompTodo.where("todo_id = ?", @todo.id).first
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_todo
      @comp_todo = CompTodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_todo_params
      params.require(:comp_todo).permit(:todo_id, :level, :task, :component_id, :title)
    end
end
