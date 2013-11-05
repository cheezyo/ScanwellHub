class Logunit < ActiveRecord::Base
  attr_accessible :unit_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status
  
  belongs_to :unit
  before_create :set_up_log
  after_save :update_components
  
  def  set_up_log
    
    
    self.send_date = DateTime.now
    self.arrive_date = nil
    self.recived_by = nil 
    self.status = 3
  end
  

  def update_components
    unit = Unit.find(self.unit_id)
    unit.components.each do|c|
      if( ! c.logcomponents.empty? )
      
          if(c.logcomponents.last.send_date == nil)
            logcomp = Logcomponent.new   
          else
            logcomp = c.logcomponents.last  
          end
      else
        logcomp = Logcomponent.new  
      end
      
      logcomp.component_id = c.id
      logcomp.send_date = self.send_date
      logcomp.sent_from = self.sent_from
      logcomp.sent_by = self.sent_by
      logcomp.sent_to = self.sent_to
      logcomp.arrive_date = self.arrive_date
      logcomp.recived_by = self.recived_by
      logcomp.status = self.status
      logcomp.on_unit = self.unit_id
      logcomp.save!
    end
  end
 
end
