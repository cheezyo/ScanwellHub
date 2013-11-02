class AddTotalPerUnitToTypes < ActiveRecord::Migration
  def change
    add_column :types, :total_per_unit, :integer
  end
end
