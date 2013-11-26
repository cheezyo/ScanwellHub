module Permissions
  class MemberPermission < BasePermission
    def initialize(user)
      allow :users, [:new, :create, :edit, :update]
      allow :units, [:index]
      allow :pages, [:index, :reminders]
      allow :sessions, [:new, :create, :destroy]
      end
     # allow_param :topic, :name
    end
  end
