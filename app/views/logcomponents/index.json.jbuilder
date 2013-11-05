json.array!(@logcomponents) do |logcomponent|
  json.extract! logcomponent, :component_id, :send_date, :sent_from, :sent_by, :sent_to, :on_unit, :arrive_date, :recived_by, :status
  json.url logcomponent_url(logcomponent, format: :json)
end
