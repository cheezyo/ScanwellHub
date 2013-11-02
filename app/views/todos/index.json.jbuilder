json.array!(@todos) do |todo|
  json.extract! todo, :done
  json.url todo_url(todo, format: :json)
end
