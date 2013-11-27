class Page < ActiveRecord::Base
  

  
  def to_csv(list, options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    list.each do |obj|
      csv << obj.attributes.values_at(*column_names)
    end
  end
end
end