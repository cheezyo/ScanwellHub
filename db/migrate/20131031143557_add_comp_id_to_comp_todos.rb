class AddCompIdToCompTodos < ActiveRecord::Migration
  def change
    add_column :comp_todos, :comp_id, :integer
  end
end
