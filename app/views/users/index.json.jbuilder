json.array!(@users) do |user|
  json.extract! user, :login, :password_digest, :groups_id
  json.url user_url(user, format: :json)
end