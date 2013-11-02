class CreateActivityLogTable < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.integer :user_id
      t.string :controller
      t.string :action
      t.string :params
      t.string :note
    end
  end
end
