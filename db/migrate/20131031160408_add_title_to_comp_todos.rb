class AddTitleToCompTodos < ActiveRecord::Migration
  def change
    add_column :comp_todos, :title, :string
  end
end
