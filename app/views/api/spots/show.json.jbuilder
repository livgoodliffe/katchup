json.extract! @spot, :id, :name, :address
json.reviews @spot.reviews do |review|
  json.extract! review, :id, :rating, :notes
end
