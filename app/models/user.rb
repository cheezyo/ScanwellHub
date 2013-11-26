class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :company_id, :super_admin, :admin, :operator
  belongs_to :company
  

                                                              
end
