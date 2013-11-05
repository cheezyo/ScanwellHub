class Company < ActiveRecord::Base
  validates :name, :uniqueness => {:scope => :name}
  has_many :units
  has_many :users
  has_many :components
  attr_accessible :name
  accepts_nested_attributes_for :units, :users
  end
