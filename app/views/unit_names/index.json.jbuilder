json.array!(@unit_names) do |unit_name|
  json.extract! unit_name, :title, :description
  json.url unit_name_url(unit_name, format: :json)
end
