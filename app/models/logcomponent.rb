class Logcomponent < ActiveRecord::Base
  attr_accessible :component_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status, :on_unit
  belongs_to :component

end
