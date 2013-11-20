class AddClientToLog < ActiveRecord::Migration
  def change
    add_column :logunits, :client_id, :integer
    add_column :logcomponents, :client_id, :integer
  end
end
