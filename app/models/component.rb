class Component < ActiveRecord::Base
  attr_accessible :available, :calibrated, :commet, :comp_id, :last_check, :brand_id, :unit_id, :company_id
  validates :comp_id, :uniqueness => {:scope => :comp_id}
  belongs_to :unit
  belongs_to :company
  has_many :comp_todos
  has_many :logcomponents
  validate :setAvilability
  after_save :set_up_log
  
  
  def set_up_log
    log = Logcomponent.new
    log.component_id = self.id
    log.sent_from = 4
    log.sent_to = 4
    log.send_date = DateTime.now
    log.arrive_date = DateTime.now
    log.status = 4
    log.save
  end
  
  private 
  
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
      self.location = unit.location
      return true
      
    else 
     errors[:base] << "Unit " + unit.unit_id.to_s +  " allready has " + brand.total_per_unit.to_s + " " + brand.name + " assigned to it."
      return false
    end 
  end
end
