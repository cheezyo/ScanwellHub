class CreateLogunits < ActiveRecord::Migration
  def change
    create_table :logunits do |t|
      t.integer :unit_id
      t.date :send_date
      t.integer :sent_by
      t.integer :sent_from
      t.integer :sent_to
      t.date :arrive_date
      t.integer :recived_by
      t.integer :status

      t.timestamps
    end
  end
end
