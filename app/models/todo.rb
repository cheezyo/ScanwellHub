class Todo < ActiveRecord::Base
  belongs_to :unit_todo
  belongs_to :comp_todo
  
  attr_accessible  :done
end
