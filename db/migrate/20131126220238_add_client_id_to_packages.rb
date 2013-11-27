class AddClientIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :client_id, :integer
  end
end
