class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firt_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :password_comfirmation

      t.timestamps
    end
  end
end
