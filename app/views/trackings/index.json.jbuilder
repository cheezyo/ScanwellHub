json.array!(@trackings) do |tracking|
  json.extract! tracking, :status_id, :unit_id, :comment
  json.url tracking_url(tracking, format: :json)
end
