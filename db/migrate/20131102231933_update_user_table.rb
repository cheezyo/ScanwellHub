class UpdateUserTable < ActiveRecord::Migration
  def change
    rename_column :users, :firt_name, :first_name
    remove_column :users, :password
    remove_column :users, :password_confirmation
  end
end
