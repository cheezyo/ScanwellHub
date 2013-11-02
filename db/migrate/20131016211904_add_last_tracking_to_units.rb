class AddLastTrackingToUnits < ActiveRecord::Migration
  def change
    add_column :units, :tracking_id, :integer
  end
end
