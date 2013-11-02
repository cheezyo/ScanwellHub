class AddLocationToComponents < ActiveRecord::Migration
  def change
    add_column :components, :location, :integer
  end
end
