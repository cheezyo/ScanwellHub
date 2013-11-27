class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
  
   #@unit_todos = UnitTodo.all
   #@unit_todos = @unit_todo.where("unit_id == ?", params[:unit_id]) if  ! params[:unit_id].blank?
   
   @unit = nil
   @comp = nil

    if(params[:unit_id] != nil && params[:unit_id] != "" && Unit.exists?(params[:unit_id]))
      @unit_id = params[:unit_id]

      @unit = Unit.find(params[:unit_id])
      @unit_todos = @unit.unit_todos
      @comps = @unit.components
      
      @comp_todos =  CompTodo.where(id: @comps)

    elsif (params[:comp_id] != nil && params[:comp_id] != "" && Component.exists?(params[:comp_id]))
      @comp = Component.find(params[:comp_id])
      @comp_todos = @comp.comptodos
      @unit_todos = Array.new
            
    else       
      @unit_todos = UnitTodo.all
      @comp_todos = CompTodo.all
      
    end 
  end
  def update_individual
     Todo.update_all({done: true}, {id: params[:todo_ids]})
     redirect_to todos_path, notice: "Tasks done"
    
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
    unit_id = 
    respond_to do |format|
      if @todo.update(todo_params)
       
        format.html { redirect_to todos_url , notice: 'Todo was successfully updated.' }
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
