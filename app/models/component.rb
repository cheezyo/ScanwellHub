class Component < ActiveRecord::Base
 belongs_to :unit
 belongs_to :brand
  belongs_to :company
  has_many :comp_todos
  has_many :logcomponents
  
  attr_accessible :available, :calibrated, :commet, :comp_id, :serial_nr, :last_check, :brand_id, :unit_id, :company_id, :range
  
  before_validation :save_old_unit_id
  validates :serial_nr, :uniqueness => {:scope => :serial_nr,
    message: "Serial number must be unique" }
  
  validates :comp_id, :uniqueness => {:scope => :comp_id,
    message: "ID must be unique" }
  validate :brand_id_present
  validate :company_id_present
  validate :unit_id_change
  after_validation :set_avilability
  after_save :log_events
  before_destroy :delete_log_and_todos

 
  

  
  #Import from CSV file
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Component.create! row.to_hash

    end
  end
  

  
  private 
    
    def delete_log_and_todos
      self.logcomponents.each do |l|
        l.destroy
      end
      self.comp_todos.each do |t|
        t.destroy
      end
      
    end
    
    def save_old_unit_id
       @old_unit_id = self.unit_id_was
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
  
    def unit_id_change
    
      if ! self.logcomponents.empty? 
        # not first set up
          if self.unit_id != @old_unit_id && self.unit_id != nil && @old_unit_id != nil
              # change from unit to unit
             
              if unit_in_transit(@old_unit_id)
                    # old unit is in transit can not move
                     errors.add(:base, " Current assigned unit is currently in transit.")
              end  
              run_common_checks
              
          elsif @old_unit_id == nil && self.unit_id != nil
            # from blank to unit
            if component_in_transit
              errors.add(:base, self.brand.name + " " + self.comp_id.to_s + " is in transit and cannot be assigned a unit at the moment.")
            end
            run_common_checks
          elsif self.unit_id == nil && @old_unit_id != nil
            # from unit to blank
            if component_in_transit
              errors.add(:base, self.brand.name + " " + self.comp_id.to_s + " is in transit and cannot be released from unit.")
            end
          end
      end
   end
  # helper method
  def run_common_checks
    if unit_id_not_valid
        # unit_id is not valid
        errors.add(:base, "The unit you are trying to assign is not valid. Please try again.")
   
    elsif location_not_equal
          # new unit is not in the same location as component
          errors.add(:base, self.brand.name + " " + self.comp_id + " is not in the same location as the unit you try to assign it to. Yoo will have to send it to that location first.")
    
    elsif unit_in_transit(self.unit_id)
          # unit is in transit and can not be assigned components
          errors.add(:base, "Unit is in transit and you can not assign components to units that are not recived yet.")
     elsif no_capacity
          # unit can not assing more of this type of component
          errors.add(:base, "Unit " + self.unit.unit_id.to_s + " has allready " + 
                      self.brand.total_per_unit.to_s + " " + self.brand.name + 
                      " assigned. " + self.brand.name +  " " + self.comp_id.to_s +
                      " was not assigned")
    end
  end
  def no_capacity
    self.unit.components.where("brand_id = ?", self.brand_id).count ==
                    self.brand.total_per_unit
  end
  
  def location_not_equal
    self.logcomponents.last.sent_to != self.unit.logunits.last.sent_to
  end
  
  def unit_in_transit(unit_id)
    Unit.find(unit_id).logunits.last.status == 
    RegisterTest2::Application::STATUS_IN_TRANSIT
  end
  
  def unit_id_not_valid
    ! Unit.exists?(self.unit_id)
  end
  
  def component_in_transit
    self.logcomponents.last.status == 
    RegisterTest2::Application::STATUS_IN_TRANSIT
  end
  
  # after validation
  def set_avilability
    if self.unit_id.nil? 
      self.available = true
    else
      self.available = false
    end
  end
  
  # after save
  def log_events
    if self.logcomponents.empty?
       self.unit_id != nil ? log_component_change(self.unit_id) : log_component_change
       
    elsif self.unit_id != @old_unit_id && self.unit_id != nil && @old_unit_id != nil
      # from unit to unit
      log_component_change(self.unit_id)
    elsif @old_unit_id == nil && self.unit_id != nil
          # from blank to unit
          log_component_change(self.unit_id)
    elsif self.unit_id == nil && @old_unit_id != nil
    # from unit to blank
      log_component_released
    end
  end

  
  #Set up log for new component not assigned any unit
  def log_component_released
    log = Logcomponent.new
    log = self.logcomponents.last
    log.on_unit = nil
    log.save
  end
  def log_component_change(unit_id = nil)
    
      log = Logcomponent.new
      log.component_id = self.id
      
      log.send_date = DateTime.now
      log.arrive_date = DateTime.now
      if unit_id.nil?
        log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
        log.sent_to = RegisterTest2::Application::LOCATION_SCANWELL_NO
        log.status = Status.find(Location.find(RegisterTest2::Application::LOCATION_SCANWELL_NO).status).id
        log.client_id = self.company_id
      elsif Unit.exists?(unit_id)
        unit = Unit.find(unit_id)
        log.sent_from = unit.logunits.last.sent_to
        log.sent_to = unit.logunits.last.sent_to
        log.status = unit.logunits.last.status
        log.client_id = unit.logunits.last.client_id
        log.on_unit = unit.id
      else
        errors.add(:base, "Unit id is not found")
      end 
      log.save
     
  end
end # end class
