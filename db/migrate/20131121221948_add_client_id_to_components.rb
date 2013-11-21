class AddClientIdToComponents < ActiveRecord::Migration
  def change
    add_column :components, :client_id, :integer
  end
end
