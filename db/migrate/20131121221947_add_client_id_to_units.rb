class AddClientIdToUnits < ActiveRecord::Migration
  def change
    add_column :units, :client_id, :integer
  end
end
