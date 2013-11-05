class Location < ActiveRecord::Base
  attr_accessible :name, :more
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => :name}
end
