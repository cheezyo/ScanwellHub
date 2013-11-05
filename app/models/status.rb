class Status < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  validates :name, :uniqueness => {:scope => :name}
  
end
