class CompTodo < ActiveRecord::Base
  has_one :todo
  belongs_to :component
  before_save :new_todo
  before_destroy :destroy_todo
  
  attr_accessible :todo_id, :component_id, :level, :task,:title
  validates :component_id, presence: true
  validates :level, presence: true
  validates :task, presence: true
  validates :title, presence: true
  
  
  
  private 
  
  def new_todo
    todo = Todo.new
    todo.done = false
    todo.save!
    self.todo_id = todo.id
    
  end

  def destroy_todo
    Todo.find(self.todo_id).destroy!
  end
end
