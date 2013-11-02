class Status < ActiveRecord::Base
  attr_accessible :name
  validates :name, :uniqueness => {:scope => :name}
  has_many :trackings
end
