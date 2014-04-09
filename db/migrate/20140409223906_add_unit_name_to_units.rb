class AddUnitNameToUnits < ActiveRecord::Migration
  def change
    add_column :units, :unit_name_id, :integer
  end
end
