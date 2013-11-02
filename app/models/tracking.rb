class Tracking < ActiveRecord::Base
    attr_accessible :status_id, :unit_id, :comment, :from, :to, :action_name, :user_id
     before_save :check_status
     belongs_to :status
     def check_status
      #unit = Unit.where("unit_id = ?", self.unit_id).first
     # if unit.tracking_id != nil
      #old_tracking = Tracking.find(unit.tracking_id)
      
      #if(old_tracking.status_id == self.status_id || self.from == self.to)
       # false
      #else 
       # true
      #end
      #end
     end
     
  def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |tracking|
      csv << tracking.attributes.values_at(*column_names)
    end
  end
end
end
