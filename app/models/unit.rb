class Unit < ActiveRecord::Base
    attr_accessible :approved, :comment, :last_check, :location, :unit_id, :company_id, :tracking_id
    validates :unit_id, :uniqueness => {:scope => :unit_id}
  belongs_to :company
  has_many :components
  has_many :unit_todos
  has_many :logunits
 
 after_save :logunit
   
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
  log.sent_from = 4
  log.sent_to = 4
  log.save
end
end
