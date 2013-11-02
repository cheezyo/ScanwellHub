class RemoveColumnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :paasword
    remove_column :users, :password_confirmation
  end
end
