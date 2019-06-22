json.array! @reviews do |review|
  json.extract! review, :id, :notes, :rating, :image, :spot_id
end
