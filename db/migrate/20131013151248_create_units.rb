class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :unit_id
      t.integer :location
      t.date :last_check
      t.boolean :approved
      t.text :comment

      t.timestamps
    end
  end
end
