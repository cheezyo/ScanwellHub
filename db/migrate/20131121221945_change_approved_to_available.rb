class ChangeApprovedToAvailable < ActiveRecord::Migration
  def change
    rename_column :units, :approved, :available
  end
end
