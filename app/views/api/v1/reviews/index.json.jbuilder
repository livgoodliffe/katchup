json.array! @reviews do |review|
  json.extract! review, :id, :notes, :rating, :image, :spot_id, :user_id
end

# You can use ruby in here eg "if"
