class Unit < ActiveRecord::Base

  belongs_to :company
  has_many :components
  has_many :unit_todos
  has_many :logunits
  
  attr_accessible :available, :comment, :last_check, :location, :unit_id, :company_id, :tracking_id, :client_id
  validates :unit_id, presence: true
  validates :unit_id, :uniqueness => {:scope => :unit_id, message: "id allready taken. Must be unique."}
  validate :company_exists
   
  after_create :logunit
  before_create :set_available
   
def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |unit|
      csv << unit.attributes.values_at(*column_names)
    end
  end
end

def logunit
  log = Logunit.new
  log.unit_id = self.id
  log.send_date = DateTime.now
  log.sent_from = RegisterTest2::Application::LOCATION_SCANWELL_NO
  log.sent_to = RegisterTest2::Application::LOCATION_SCANWELL_NO
  log.status = Status.find(Location.find(RegisterTest2::Application::LOCATION_SCANWELL_NO).status).id
  log.arrive_date = DateTime.now
  log.save
end

def set_available
  self.available = true
end
private 

def company_exists
    if company_id.blank?
      errors.add(:base, "You must choose an owner") 
    end
  end
end
