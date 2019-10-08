json.array! @spots do |spot|
  json.extract! spot, :id, :name, :address
end
