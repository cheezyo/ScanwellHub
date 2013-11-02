class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.integer :status_id
      t.integer :unit_id
      t.text :comment

      t.timestamps
    end
  end
end
