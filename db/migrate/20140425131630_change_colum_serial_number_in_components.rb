class ChangeColumSerialNumberInComponents < ActiveRecord::Migration
  def change
    change_column :components, :serial_nr, :string
  end
end
