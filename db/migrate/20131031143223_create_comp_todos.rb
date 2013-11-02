class CreateCompTodos < ActiveRecord::Migration
  def change
    create_table :comp_todos do |t|
      t.integer :todo_id
      t.string :level
      t.text :task

      t.timestamps
    end
  end
end
