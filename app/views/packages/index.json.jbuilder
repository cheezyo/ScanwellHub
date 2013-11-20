json.array!(@packages) do |package|
  json.extract! package, :origin, :destiantion, :arrival_date, :reciver, :status, :po, :ref, :coment, :pack_nr, :unit_ids, :components_ids
  json.url package_url(package, format: :json)
end
