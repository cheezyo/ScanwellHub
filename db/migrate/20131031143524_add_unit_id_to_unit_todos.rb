class AddUnitIdToUnitTodos < ActiveRecord::Migration
  def change
    add_column :unit_todos, :unit_id, :integer
  end
end
