class Component < ActiveRecord::Base
  attr_accessible :available, :calibrated, :commet, :comp_id, :last_check, :brand_id, :unit_id, :company_id
  validate :serial_number  
  validates :comp_id, :uniqueness => {:scope => :comp_id,
    message: "Serial number must be unique" }
  validate :brand_id_present
  validate :company_exists
  
  
  belongs_to :unit
  belongs_to :company
  has_many :comp_todos
  has_many :logcomponents
  validate :setAvilability
  after_save :set_up_log
  

  def set_up_log
    log = Logcomponent.new
    log.component_id = self.id
    log.sent_from = 1
    log.sent_to = 1
    log.send_date = DateTime.now
    log.arrive_date = DateTime.now
    log.status = 2
    log.save
  end
  
  private 
  def company_exists
    if company_id.blank?
      errors.add(:base, "You must choose an owner") 
    end
  end
  def brand_id_present
    if brand_id.blank?
        errors.add(:base, "You must choose type of component")        
    end
  end
  
  def serial_number
    if comp_id.blank?
     errors.add(:base, "Serialnumber can not be blank")   
    end
  end
  
  def setAvilability
    if self.unit_id == nil || self.unit_id == ""
      self.available = true
      return true
    else 
      
      return validate_unit_component_list
      
    end
  end
  
  def validate_unit_component_list
    unit = Unit.find(self.unit_id)
    component_on_unit = unit.components.where("brand_id = ?", self.brand_id)
    brand = Brand.find(self.brand_id)
   
    if(component_on_unit.count < brand.total_per_unit)
      self.available = false
      
      return true
      
    else 
     errors[:base] << "Unit " + unit.unit_id.to_s +  " allready has " + brand.total_per_unit.to_s + " " + brand.name + " assigned to it."
      return false
    end 
  end
end
