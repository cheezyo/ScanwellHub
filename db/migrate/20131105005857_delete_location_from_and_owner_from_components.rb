class DeleteLocationFromAndOwnerFromComponents < ActiveRecord::Migration
  def change
    remove_column :components, :location
    add_column :components, :owner_id, :integer
  end
end
