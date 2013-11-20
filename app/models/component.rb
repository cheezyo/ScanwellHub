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
  validate :company_id_present
  validate :set_avilability
  after_validation :save_old_unit_id
  after_save :has_unit_changed #:set_up_log_first_time
  

  
  #Import from CSV file
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      component = find_by_comp_id(row["comp_id"]) || new 
      component.attributes = row.to_hash
      component.save!

    end
  end
  

  
  private 
  
    def save_old_unit_id
       @old_unit_id = self.unit_id_was
    end
    #Log if component changes unit
    def has_unit_changed
      
      
    if self.unit_id != @old_unit_id && ! self.unit_id.blank?
      new_unit = Unit.find(self.unit_id)
      
      log = Logcomponent.new
      log.component_id = self.id
      if self.logcomponents.empty?
        log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
      else 
        log.sent_from = self.logcomponents.last.sent_to
      end
      
      log.sent_to = new_unit.logunits.last.sent_to
      log.send_date = DateTime.now
      log.on_unit = new_unit.id
      if log.sent_from == log.sent_to
          log.arrive_date = DateTime.now
          log.status = new_unit.logunits.last.status 
      else
          log.status = 2
      end 
      log.save
    #elsif ! self.unit_id_was.blank? && self.unit_id.blank?
      
    elsif self.unit_id.blank? && self.logcomponents.empty?
        set_up_log_first_time
        
    end
   
  end
  
    #Set up log for component on create
  def set_up_log_first_time
    #if(self.logcomponents.empty?)
      log = Logcomponent.new
      log.component_id = self.id
      log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
      log.sent_to = RegisterTest2::Application::LOCATION_SCANWELL_NO
      log.send_date = DateTime.now
      log.arrive_date = DateTime.now
      #log.on_unit = self.unit_id
      log.status = RegisterTest2::Application::STATUS_ON_LAND
      log.save
    #end 
  end
  
  #Validations
  
  def company_id_present
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
