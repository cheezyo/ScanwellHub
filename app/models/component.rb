class Component < ActiveRecord::Base
 belongs_to :unit
  belongs_to :company
  has_many :comp_todos
  has_many :logcomponents
  
  
  attr_accessible :available, :calibrated, :commet, :comp_id, :last_check, :brand_id, :unit_id, :company_id, :range
  validate :serial_number  
  validates :comp_id, :uniqueness => {:scope => :comp_id,
    message: "Serial number must be unique" }
  validate :brand_id_present
  validate :company_exists
  validate :set_avilability

  after_save :set_up_log
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      component = find_by_comp_id(row["comp_id"]) || new 
      component.attributes = row.to_hash
      component.save!

    end
  end

  def set_up_log
    if(self.logcomponents.empty?)
      log = Logcomponent.new
      log.component_id = self.id
      log.sent_from = 4
      log.sent_to = 4
      log.send_date = DateTime.now
      log.arrive_date = DateTime.now
      log.status = 4
      log.save
    end 
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
  
  def set_avilability
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
  
  
  #TODO 
  def validate_component_update
    old_unit_id = self.unit_id_was
    new_unit_id = self.unit_id
    
    if old_unit_id == new_unit_id
      return true
    
    elsif new_unit_id != nil 
      components_on_unit = self.unit.components.where("brand_id = ?", self.brand_id)
      brand = Brand.find(self.brand_id)
      
      if(components_on_unit.count < brand.total_per_unit)
      
        logcomp = Logcomponent.new
        comp_location = self.logcomponents.last.sent_to
        new_unit_location = self.unit.logunits.last.sent_to
        
        logcomp.send_date = DateTime.now
        logcomp.sent_from = comp_location
        logcomp.sent_to = new_unit_location
        logcomp.status = 2
        logcomp.save
        return true 
      
      else
          errors[:base] << "Unit " + unit.unit_id.to_s +  " allready has " + brand.total_per_unit.to_s + " " + brand.name + " assigned to it."
          return false
      end
    
    else
        return true
     
    end
  end
  

  

end
