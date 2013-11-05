class RenameOwnerIdToCompanyIdInComponents < ActiveRecord::Migration
  def change
    rename_column :components, :owner_id, :company_id
  end
end
