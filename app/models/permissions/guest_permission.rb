module Permissions
  class GuestPermission < BasePermission
    def initialize     
      allow :sessions, [:new, :create]
      allow :pages, [:index]
    end
  end
end