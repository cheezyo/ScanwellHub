module Permissions
  class AdminPermission < BasePermission
    def initialize(user)
      allow :brands, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :comp_todos, [:task_done, :undo_task, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :companies, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :components, [:edit_individual, :update_individual, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :locations, [:new, :create, :edit, :update, :show, :index, :destroy]
      
      allow :logcomponents, [:new, :create, :edit, :update, :show, :index]
      allow :logunits, [:new, :create, :edit, :update, :show, :index]
      allow :packages, [:new, :create, :edit, :update, :show, :index, :recive]
      allow_param :package, [:origin, :destiantion, :client_id,
                  :arrival_date, :reciver, :status, :po, :ref, :coment, :pack_nr, :unit_ids, :components_ids]

      
      allow :pages, [:new, :create, :edit, :update, :show, :index, :destroy, :reminders]
      allow :sessions, [:new, :create, :destroy]
      allow :statuses, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :todos, [:update_individual, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :unit_todos, [:task_done, :undo_task, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :units, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :users, [:new, :create, :edit, :update, :show, :index, :destroy]
      
      
    end
  end
end