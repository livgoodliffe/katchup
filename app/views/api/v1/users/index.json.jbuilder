json.array! @users do |user|
  json.extract! user, :name, :email
end
