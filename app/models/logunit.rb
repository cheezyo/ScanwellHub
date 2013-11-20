class Logunit < ActiveRecord::Base
  attr_accessible :package_id, :unit_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status, :client_id
  belongs_to :package
  belongs_to :unit

end
