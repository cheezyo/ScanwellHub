json.array!(@comp_todos) do |comp_todo|
  json.extract! comp_todo, :todo_id, :level, :task
  json.url comp_todo_url(comp_todo, format: :json)
end
