class AddRangeToComponents < ActiveRecord::Migration
  def change
    add_column :components, :range, :string
  end
end
