class DropActivityLogTable < ActiveRecord::Migration
  def change
    drop_table :activity_logs
  end
end
