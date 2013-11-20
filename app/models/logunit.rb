class Logunit < ActiveRecord::Base
  attr_accessible :unit_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status
  
  belongs_to :unit
  before_create :set_up_log
  
  def  set_up_log
    
    
    self.send_date = DateTime.now
    self.arrive_date = nil
    self.recived_by = nil 
    self.status = RegisterTest2::Application::STATUS_IN_TRANSIT
  end
   
end
