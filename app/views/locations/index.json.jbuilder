json.array!(@locations) do |location|
  json.extract! location, :name, :more
  json.url location_url(location, format: :json)
end
