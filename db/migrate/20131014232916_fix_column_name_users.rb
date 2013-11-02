class FixColumnNameUsers < ActiveRecord::Migration
  def change
     rename_column :users, :password_confirmation, :password_confirmation
     rename_column :users, :firt_name, :first_name 
  end
end
