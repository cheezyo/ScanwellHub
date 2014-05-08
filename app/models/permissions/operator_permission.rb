module Permissions
  class OperatorPermission < BasePermission
    def initialize(user)
      allow :brands, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :comp_todos, [:task_done, :undo_task, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :companies, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :components, [:edit_individual, :update_individual, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :locations, [:new, :create, :edit, :update, :show, :index, :destroy]
      
      allow :logcomponents, [:new, :create, :show, :index]
      allow :logunits, [:new, :create, :show, :index]
      allow :packages, [:new, :create, :show, :index, :recive]
      allow_param :package, [:destiantion, :origin, :arrival_date, :reciver, 
                             :status, :po, :ref, :coment, :pack_nr, :unit_ids, :components_ids]

      
      allow :pages, [:new, :create, :edit, :update, :show, :index, :destroy, :reminders]
      allow :sessions, [:new, :create, :destroy]
      allow :statuses, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :todos, [:update_individual, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :unit_todos, [:task_done, :undo_task, :new, :create, :edit, :update, :show, :index, :destroy]
      allow :units, [:new, :create, :edit, :update, :show, :index, :destroy]
      allow :users, [:edit, :update, :show, :index]
      allow_param :user, [:first_name, :last_name, :email, :password, :password_confirmation, :company_id]
      
      end
    end
  end