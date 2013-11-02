class RenameTypeIdToBrandIdInComponents < ActiveRecord::Migration
  def change
    rename_column :components, :type_id, :brand_id
  end
end
