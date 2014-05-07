class Logcomponent < ActiveRecord::Base
  attr_accessible :package_id, :component_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status, :on_unit, :client_id
  belongs_to :component
  belongs_to :package
  
  
  

end
