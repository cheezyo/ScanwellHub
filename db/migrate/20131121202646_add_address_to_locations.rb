class AddAddressToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :address, :string
    add_column :locations, :postal_code, :string
    add_column :locations, :city, :string
    add_column :locations, :country, :string
  end
end
