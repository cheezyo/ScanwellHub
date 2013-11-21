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
  after_save :has_unit_changed 
  

  
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
    
    #Check if component is assigned a unit or is new and creates log entry according to status 
    def has_unit_changed
        
    if self.unit_id != @old_unit_id && ! self.unit_id.blank?
      new_unit = Unit.find(self.unit_id)
      
      log = Logcomponent.new
      log.component_id = self.id
      #If on creating component the component is directly assigned a unit send unit from primary location
      if self.logcomponents.empty?
        log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
      #Else take last location component was sent to and send from there
      else 
        log.sent_from = self.logcomponents.last.sent_to
      end
      
      log.sent_to = new_unit.logunits.last.sent_to
      log.send_date = DateTime.now
      log.on_unit = new_unit.id
      
      #If unit assigned to component has same location check in directly
      if log.sent_from == log.sent_to
          log.arrive_date = DateTime.now
          log.status = new_unit.logunits.last.status 
          
      #Else not set arrive date and set status in transit so user must check in component on arrival
      else
          log.status = RegisterTest2::Application::STATUS_IN_TRANSIT
      end 
      log.save
      
    #elsif ! @old_unit_id.blank? && self.unit_id.blank?

      
    elsif self.unit_id.blank? && self.logcomponents.empty?
       
        set_up_log_first_time
        
    end
   
  end
  
    #Set up log for new component not assigned any unit
  def set_up_log_first_time
    
      log = Logcomponent.new
      log.component_id = self.id
      log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
      log.sent_to = RegisterTest2::Application::LOCATION_SCANWELL_NO
      log.send_date = DateTime.now
      log.arrive_date = DateTime.now
      log.status = RegisterTest2::Application::STATUS_ON_LAND
      log.save
     
  end
  
  #Custom Validations
  
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
  
    #Validates if assigned unit has capacity to assign this type of component. Every Brand has a total_per_unit variable.
    def validate_unit_component_list
      unit = Unit.find(self.unit_id)
      components_on_unit = unit.components.where("brand_id = ?", self.brand_id)
      brand = Brand.find(self.brand_id)
     
      # If component can be assigned this unit availability of component is set to false.
      if(components_on_unit.count < brand.total_per_unit || components_on_unit.includes(self) )
        self.available = false
        
        return true
        
      else 
       # Rendering error message
       errors[:base] << "Unit " + unit.unit_id.to_s +  " allready has " + brand.total_per_unit.to_s + " " + brand.name + " assigned to it."
        return false
      end 
  end
  
end # end class
