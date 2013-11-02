class AddFromAndToToTrackings < ActiveRecord::Migration
  def change
    add_column :trackings, :from, :integer
    add_column :trackings, :to, :integer
  end
end
