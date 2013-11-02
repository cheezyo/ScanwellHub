class RenameTypesToBrands < ActiveRecord::Migration
  def change
    rename_table :types, :brands
  end
end
