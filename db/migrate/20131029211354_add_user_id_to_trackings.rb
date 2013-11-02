class AddUserIdToTrackings < ActiveRecord::Migration
  def change
    add_column :trackings, :user_id, :integer
  end
end
