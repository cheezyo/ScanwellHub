class CreateUnitTodos < ActiveRecord::Migration
  def change
    create_table :unit_todos do |t|
      t.integer :todo_id
      t.string :level
      t.text :task

      t.timestamps
    end
  end
end
