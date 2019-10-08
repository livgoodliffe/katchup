json.extract! @spot, :id, :name, :location
json.reviews @spot.reviews do |review|
  json.extract! review, :rating, :notes
end
