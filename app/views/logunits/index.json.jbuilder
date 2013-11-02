json.array!(@logunits) do |logunit|
  json.extract! logunit, :unit_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status
  json.url logunit_url(logunit, format: :json)
end
