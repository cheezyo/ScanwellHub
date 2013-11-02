json.array!(@brands) do |brand|
  json.extract! brand, :name
  json.url type_url(brand, format: :json)
end
