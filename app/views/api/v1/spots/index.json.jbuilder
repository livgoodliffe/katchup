
json.array! @spots do |spot|
  json.id spot.id
  json.name spot.name
  json.address spot.address
  json.image spot.images[0].image
end
