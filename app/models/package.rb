class Package < ActiveRecord::Base
  attr_accessible :origin, :destiantion, :arrival_date, :reciver, :status, :po, :ref, :coment, :pack_nr, :unit_ids, :components_ids
  serialize  :unit_ids
  serialize  :components_ids
  
  validates :pack_nr, :uniqueness => {:scope => :pack_nr, message: "This package id is allready taken. Must be unique."}
  validates :origin, presence: true
  validates :destiantion, presence: true
  validates :status, presence: true
  validate :validate_items_locations
  validate :origin_and_destination
  after_create :log_items
  
  
  def log_items
    if self.unit_ids != nil 
      self.unit_ids.each do | unit |
        u = Unit.find(unit)
        u.update_attribute(:available, false)
        l = Logunit.new
        l.unit_id = u.id
        l.sent_from = self.origin
        #l.sent_by = current_user.id
        l.sent_to = self.destiantion
        l.send_date = self.created_at
        l.status = self.status
        l.package_id = self.id
        l.save
        
        if u.components != nil 
          u.components.each do | c |
             l = Logcomponent.new 
            
             l.component_id = c.id
             l.sent_from = self.origin
             #l.sent_by = current_user.id
             l.sent_to = self.destiantion
             l.send_date = self.created_at
             l.status = self.status
             l.package_id = self.id
             l.save
          end
        end
      end
    end
    if self.components_ids != nil
       self.components_ids.each do |comp|
         c = Component.find(comp)
         c.update_attribute(:available, false)
         l  = Logcomponent.new
        l.component_id = c.id
        l.sent_from = self.origin
        #l.sent_by = current_user.id
        l.sent_to = self.destiantion
        l.send_date = self.created_at
        l.status = self.status
        l.package_id = self.id
        l.save
       end
     end
  end
  
  def origin_and_destination
    if self.origin == self.destiantion
      errors.add(:base, "Package origin and destination is set to the same location, please change one of them.")
    end
  end
    
  def validate_items_locations
    
    if self.unit_ids != nil
      self.unit_ids.each do |unit|
        u = Unit.find(unit)
        if self.origin != u.logunits.last.sent_to
          errors.add(:base, "Unit " + u.unit_id.to_s + " is not located in the same location from where you are trying to send from. ")   
        end
        
      end
      
    end
    
    if self.components_ids != nil 
      self.components_ids.each do |comp|
        c = Component.find(comp)
        if self.origin != c.logcomponents.last.sent_to
          errors.add(:base, "Component " + c.comp_id.to_s + " " + c.brand.name + " is not located in the same location from where you are trying to send from")  
        end
      end
      
    end
    
    
 
  end
end
