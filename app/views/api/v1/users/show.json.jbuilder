json.extract! @user, :id, :first_name, :last_name, :email, :avatar

# json.wishlists @user.wishlists do |wish|
#   json.extract! wish, :spot_id
#     json.user do
#       json.id review.user.id
#       json.first_name review.user.first_name
#     end
# end
