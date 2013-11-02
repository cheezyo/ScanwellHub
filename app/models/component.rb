class Component < ActiveRecord::Base
  attr_accessible :available, :calibrated, :commet, :comp_id, :last_check, :brand_id, :unit_id, :location
  validates :comp_id, :uniqueness => {:scope => :comp_id}
  belongs_to :unit
  has_many :comp_todos
  
  validate :setAvilability
  
  
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
