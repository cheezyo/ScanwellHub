class AddTitleToUnitTodos < ActiveRecord::Migration
  def change
    add_column :unit_todos, :title, :string
  end
end
