json.array! @reviews do |review|
  json.extract! review, :rating, :notes, :image, :user_id, :spot_id
end
