class UnitTodosController < ApplicationController
  before_action :set_unit_todo, only: [:show, :edit, :update, :destroy]

  # GET /unit_todos
  # GET /unit_todos.json
  def index
    @unit_todos = UnitTodo.all
  end

  # GET /unit_todos/1
  # GET /unit_todos/1.json
  def show
  end

  # GET /unit_todos/new
  def new
    @unit_todo = UnitTodo.new
    @unit_id = params[:unit_id].to_i
  end

  # GET /unit_todos/1/edit
  def edit
  end

  # POST /unit_todos
  # POST /unit_todos.json
  def create
    @unit_todo = UnitTodo.new(unit_todo_params)

    respond_to do |format|
      if @unit_todo.save
        format.html { redirect_to @unit_todo, notice: 'Unit todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @unit_todo }
      else
        format.html { render action: 'new' }
        format.json { render json: @unit_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_todos/1
  # PATCH/PUT /unit_todos/1.json
  def update
    respond_to do |format|
      if @unit_todo.update(unit_todo_params)
        format.html { redirect_to @unit_todo, notice: 'Unit todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @unit_todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_todos/1
  # DELETE /unit_todos/1.json
  def destroy
    @unit_todo.destroy
    respond_to do |format|
      format.html { redirect_to unit_todos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_todo
      @unit_todo = UnitTodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_todo_params
      params.require(:unit_todo).permit(:todo_id, :level, :task, :unit_id, :title)
    end
end
