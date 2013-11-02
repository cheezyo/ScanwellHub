class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :comp_id
      t.date :last_check
      t.integer :unit_id
      t.integer :type_id
      t.boolean :available
      t.boolean :calibrated
      t.text :commet

      t.timestamps
    end
  end
end
