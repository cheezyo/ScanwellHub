class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :password_comfirmation, :password_confirmation
  end
end
