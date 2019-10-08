json.array! @spots do |spot|
  json.extract! spot, :name, :location
end
