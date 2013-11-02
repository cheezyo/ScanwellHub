class CompTodo < ActiveRecord::Base
  has_one :todo
  belongs_to :component
  
  attr_accessible :todo_id, :component_id, :level, :task,:title
  
  before_save :new_todo
  before_destroy :destroy_todo
  
  
  private 
  
  def new_todo
    todo = Todo.new
    todo.save!
    
    self.todo_id = todo.id
    
  end

  def destroy_todo
    Todo.find(self.todo_id).destroy!
  end
end
