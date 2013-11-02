class Brand < ActiveRecord::Base
  attr_accessible :name, :total_per_unit

  validates :name, :uniqueness => {:scope => :name}
end
