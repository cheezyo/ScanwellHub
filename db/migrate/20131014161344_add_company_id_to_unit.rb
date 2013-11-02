class AddCompanyIdToUnit < ActiveRecord::Migration
  def change
    add_column :units, :company_id, :integer
  end
end
