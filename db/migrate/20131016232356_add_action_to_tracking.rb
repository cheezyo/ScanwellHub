class AddActionToTracking < ActiveRecord::Migration
  def change
    add_column :trackings, :action, :string
  end
end
