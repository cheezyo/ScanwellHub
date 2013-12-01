module Permissions
  class MemberPermission < BasePermission
    def initialize(user)
      allow :brands, [ :show, :index]
      allow :comp_todos, [:show, :index]
      allow :companies, [:show, :index]
      allow :components, [:show, :index]
      allow :locations, [:show, :index]
      
      allow :logcomponents, [:show, :index]
      allow :logunits, [:show, :index]
      allow :packages, [:index]
     
      allow :pages, [:show, :index, :reminders]
      allow :sessions, [:new, :create, :destroy]
      allow :statuses, [:show, :index]
      allow :todos, [:show, :index]
      allow :unit_todos, [:show, :index]
      allow :units, [:show, :index]
      allow :users, [:edit, :update, :show, :index]
      end
     # allow_param :topic, :name
    end
  end
