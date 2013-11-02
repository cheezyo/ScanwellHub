json.array!(@users) do |user|
  json.extract! user, :firt_name, :last_name, :email, :password, :password_comfirmation
  json.url user_url(user, format: :json)
end
