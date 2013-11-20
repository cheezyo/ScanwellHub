class AddPackageIdToLog < ActiveRecord::Migration
  def change
    add_column :logcomponents, :package_id, :integer
    add_column :logunits, :package_id, :integer
  end
end
