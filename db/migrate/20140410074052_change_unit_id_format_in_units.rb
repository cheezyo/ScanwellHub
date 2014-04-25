class ChangeUnitIdFormatInUnits < ActiveRecord::Migration
  def change
    change_column :units, :unit_id, :string
     add_column :components, :serial_nr, :integer
  end
end
