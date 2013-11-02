json.array!(@units) do |unit|
  json.extract! unit, :unit_id, :location, :last_check, :approved, :comment
  json.url unit_url(unit, format: :json)
end
