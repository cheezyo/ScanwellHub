class FixColumnActionToActionName < ActiveRecord::Migration
   def change
    rename_column :trackings, :action, :action_name
  end
end
