class CreateLogcomponents < ActiveRecord::Migration
  def change
    create_table :logcomponents do |t|
      t.integer :component_id
      t.date :send_date
      t.integer :sent_from
      t.integer :sent_by
      t.integer :sent_to
      t.integer :on_unit
      t.date :arrive_date
      t.integer :recived_by
      t.integer :status

      t.timestamps
    end
  end
end
