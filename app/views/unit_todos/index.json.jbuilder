json.array!(@unit_todos) do |unit_todo|
  json.extract! unit_todo, :todo_id, :level, :task
  json.url unit_todo_url(unit_todo, format: :json)
end
