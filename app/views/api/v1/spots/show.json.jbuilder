json.extract! @spot, :id, :name

# have to know the user?

json.reviews @spot.reviews do |review|
  json.extract! review, :id, :notes, :rating, :image
  json.user do
    json.id review.user.id
    json.email review.user.email
  end
end
