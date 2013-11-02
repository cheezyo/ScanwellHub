class CompTodosController < ApplicationController
  before_action :set_comp_todo, only: [:show, :edit, :update, :destroy]

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

  # POST /comp_todos
  # POST /comp_todos.json
  def create
    @comp_todo = CompTodo.new(comp_todo_params)

    respond_to do |format|
      if @comp_todo.save
        format.html { redirect_to @comp_todo, notice: 'Comp todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comp_todo }
      else
        format.html { render action: 'new' }
        format.json { render json: @comp_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comp_todos/1
  # PATCH/PUT /comp_todos/1.json
  def update
    respond_to do |format|
      if @comp_todo.update(comp_todo_params)
        format.html { redirect_to @comp_todo, notice: 'Comp todo was successfully updated.' }
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
      format.html { redirect_to comp_todos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comp_todo
      @comp_todo = CompTodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_todo_params
      params.require(:comp_todo).permit(:todo_id, :level, :task, :component_id, :title)
    end
end
