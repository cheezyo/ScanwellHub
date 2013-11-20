class AddStatusToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :status, :integer
    
  end
end
