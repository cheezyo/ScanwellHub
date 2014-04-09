class CreateUnitNames < ActiveRecord::Migration
  def change
    create_table :unit_names do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
