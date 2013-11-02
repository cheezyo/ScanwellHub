class ChangeCompIdToComponentIdInCompTodos < ActiveRecord::Migration
  def change
    rename_column :comp_todos, :comp_id, :component_id
  end
end
