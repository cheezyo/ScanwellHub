class UnitTodo < ActiveRecord::Base
  has_one :todo
  belongs_to :unit
  
  attr_accessible :todo_id, :unit_id, :level, :task, :title
  
  before_create :new_todo
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
