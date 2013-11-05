class Brand < ActiveRecord::Base
  attr_accessible :name, :total_per_unit
  
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => :name}
  validates :total_per_unit, presence: true
  validates :total_per_unit, numericality: { only_integer: true }
end
