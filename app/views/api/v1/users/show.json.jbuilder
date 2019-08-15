json.extract! @user, :id, :first_name, :email

# have to know the user?

# json.reviews @spot.reviews do |review|
#   json.extract! review, :id, :notes, :rating, :image
#   json.user do
#     json.id review.user.id
#     json.name review.user.first_name
#   end
# end
