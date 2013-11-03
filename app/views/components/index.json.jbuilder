json.array!(@components) do |component|
  json.extract! component, :comp_id, :last_check, :unit_id, :brand_id, :available, :calibrated, :commet
  json.url component_url(component, format: :json)
end
