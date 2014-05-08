module Permissions
  def self.permission_for(user)
    if user.nil?
      GuestPermission.new
    elsif user.super_admin?
      SuperAdminPermission.new(user)
    elsif user.admin?
      AdminPermission.new(user)
    elsif user.operator?
      OperatorPermission.new(user)
    else
      MemberPermission.new(user)
    end
  end
end