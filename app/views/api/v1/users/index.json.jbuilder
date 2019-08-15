json.array! @users do |user|
  json.extract! user, :id, :first_name, :authentication_token
end

