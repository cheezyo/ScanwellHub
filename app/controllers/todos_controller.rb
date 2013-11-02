class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Array.new
    
    if(params[:unit_id] != nil && params[:unit_id] != "" && Unit.exists?(params[:unit_id]))
      @show_unit = true
      unit = Unit.find(params[:unit_id])
      @unit_todos = unit.unit_todos
      comps = Component.where("unit_id = ?", unit.id)
      @comp_todos = Array.new()
      comps.each do |c|
        c.comp_todos.each do |a|
          @comp_todos << a
        end 
      end
    elsif (params[:comp_id] != nil && params[:comp_id] != "" && Component.exists?(params[:comp_id]))
      @show_comp = true
      @comp_todos = Component.find(params[:comp_id]).comp_todos
      
    else  
      @todos = Todo.all
    end 
  end
  def update_individual
     Todo.update_all({done: true}, {id: params[:todo_ids]})
     redirect_to todos_url
    
  end
  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @todo }
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:done, :todo_ids)
    end
end
