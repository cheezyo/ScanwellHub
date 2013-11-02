class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :company_id
  belongs_to :company
  

                                                              
end
