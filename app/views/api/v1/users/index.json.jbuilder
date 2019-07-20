json.array! @users do |user|
  json.extract! user, :id, :email, :first_name, :last_name, :authentication_token
end

