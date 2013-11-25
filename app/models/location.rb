class Location < ActiveRecord::Base
  attr_accessible :name, :more, :company_id, :address, :postal_code, :city, :country, :status
  serialize :more
  belongs_to :company
  
  validates :name, presence: true
  validates :status, presence: true
  validates :name, :uniqueness => {:scope => :name}
end
