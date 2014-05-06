class UnitName < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :units
end
