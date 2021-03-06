# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# return unless Rails.env.development?

require 'open-uri'
require 'nokogiri'
require 'faker'

puts "*** Seeding Started ***"
puts "* Deleting Old Data *"
puts "Deleting Activity Logs.."
PublicActivity::Activity.destroy_all
puts "Deleting Guests.."
Guest.destroy_all
puts "Deleting Catchups.."
Catchup.destroy_all
puts "Deleting Favourite Lists.."
Favourite.destroy_all
puts "Deleting Wishlist Lists.."
Wishlist.destroy_all
puts "Deleting Follows.."
Follow.destroy_all
puts "Deleting Friend Requests.."
FriendRequest.destroy_all
puts "Deleting Friendships.."
Friendship.destroy_all
puts "Deleting Reviews.."
Review.destroy_all
puts "Deleting Spot Images.."
Image.destroy_all
puts "Deleting Menu Items.."
MenuItem.destroy_all
puts "Deleting Spots.."
Spot.destroy_all
puts "Deleting Users.."
User.destroy_all

puts "* Seeding Data *"
SEED_USER_COUNT = 15
SEED_FRIENDSHIP_COUNT = 50
SEED_WISHLIST_COUNT = 3
SEED_FAVOURITE_COUNT = 3

puts "Adding #{SEED_USER_COUNT} Users.."

SEED_USER_COUNT.times do |n|
  user = User.new
  user.email = Faker::Internet.email
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.password = "Password123"
  user.remote_avatar_url = Faker::Avatar.image
  user.save!
  puts "Seeded User: ##{n+1}"
end

puts "Adding #{SEED_WISHLIST_COUNT} wishlists and #{SEED_FAVOURITE_COUNT} favourites to all users.."

User.all.each_with_index do |user, k|
  SEED_WISHLIST_COUNT.times { |n|
    Wishlist.create(user: user, spot: Spot.all.sample)
    puts "Seeded User ##{k+1} Wishlist Item ##{n+1}"
  }
  SEED_FAVOURITE_COUNT.times { |n|
    Favourite.create(user: user, spot: Spot.all.sample)
    puts "Seeded User ##{k+1} Favourite Item ##{n+1}"
  }
end

puts "Adding #{SEED_FRIENDSHIP_COUNT} Friendships.."

loop do
  friend = Friendship.new
  friend.user_id = User.pluck('id').sample
  friend.friend_id = User.pluck('id').sample
  next if friend.user_id == friend.friend_id
  unless Friendship.exists?(user_id: friend.user_id, friend_id: friend.friend_id )
    friend.save!
    puts "Seeded Friendship ##{Friendship.count / 2} between User (id:#{friend.user_id}) and Friend (id:#{friend.friend_id})"
  end
  break if (Friendship.count / 2) == SEED_FRIENDSHIP_COUNT
end

BASE_SELECTOR='.result'
NAME_SELECTOR='.detail a h4'

DETAIL_LINK_SELECTOR='.detail a'
DETAIL_LOCATION_SELECTOR='.detailsContainer h2+p'
DETAIL_DESCRIPTION_SELECTOR='.detailsContainer h4+p'

DETAIL_HOURS_SELECTOR='.detailsContainer .hanging'

DETAIL_IMAGES_SELECTOR='.nivoSlider img'

BASE_URL='https://whatson.melbourne.vic.gov.au'

BASE_RESTAURANT_URL='https://whatson.melbourne.vic.gov.au/diningandnightlife/restaurants/allrestaurants/pages/allrestaurants.aspx'

# please provide number in multiples of 10
SEED_SPOT_COUNT = 20 # max 700 (site can provide slightly more)

def create_menu_item(spot)
  menuitem = { spot_id:spot.id,
               name: Faker::Food.dish,
               description: Faker::Food.description,
               price: 100 + rand(2901) }

  # puts menuitem

  menuitem
end

def get_image_urls(result_detail_doc)
  image_urls = []
  result_detail_doc.css(DETAIL_IMAGES_SELECTOR).each_with_index do |element, index|
    image_url = "#{BASE_URL}#{element.attr('src')}"
    # puts "Seeded Spot Image #{index}: #{image_url}"
    image_urls << image_url
  end

  image_urls
end

def get_location(result_detail_doc)
  spot_detail_location_raw = result_detail_doc.css(DETAIL_LOCATION_SELECTOR).first.text.gsub(/([^ ]{1})Melbourne/,'\1 Melbourne')

  spot_detail_location = spot_detail_location_raw
  .gsub("\n"," ")                 # newlines into spaces
  .gsub(/([a-z])([A-Z])/,'\1 \2') # separate aA
  .gsub(/([a-z])(\d)/,'\1 \2')    #          a1
  .gsub(/(\d)([A-Z])/,'\1 \2')    #          aA
  .gsub(/(\))([A-Z])/,'\1 \2')    #          )A
  .gsub('  ', ' ').strip

  spot_detail_address = spot_detail_location
  .gsub(/(\(.*\))/,'')              # remove (*)
  .match(/([\d]+)?[^\d]+VIC( \d{4})?$/)[0] # # keep: street number (if exists) followed by .*
  .gsub('  ', ' ')

  # puts
  # puts "raw location: #{spot_detail_location_raw}"
  # puts "Seeded spot location: #{spot_detail_location}"
  # puts "Seeded spot address: #{spot_detail_address}"

  { location: spot_detail_location,
    address: spot_detail_address}
end

def get_description(result_detail_doc)
  description = result_detail_doc.css(DETAIL_DESCRIPTION_SELECTOR).text
  .gsub('.','. ')
  .gsub('  ',' ').strip
  #puts "description: #{description}"

  description
end

def get_hours(result_detail_doc)
  hours = result_detail_doc.css(DETAIL_HOURS_SELECTOR).text
  .gsub(/([a-z])([A-Z])/, '\1<br>\2')

  # puts "hours: #{hours}"
  hours
end

(SEED_SPOT_COUNT/10).times do |n|

  results =  Nokogiri::HTML(open("#{BASE_RESTAURANT_URL}?start=#{n*10}")).css(BASE_SELECTOR)

  results.each_with_index do |result, index|
    result_detail_url= result.css(DETAIL_LINK_SELECTOR).attr('href')
    result_detail_doc = Nokogiri::HTML(open("#{BASE_URL}#{result_detail_url}"))

    location = get_location(result_detail_doc)
    description = get_description(result_detail_doc)
    hours = get_hours(result_detail_doc)
    image_urls = get_image_urls(result_detail_doc)

    spot = {
      name: result.css(NAME_SELECTOR).text.strip,
      location: location[:location],
      address: location[:address],
      description: description,
      hours: hours,
    }


    spot = Spot.create(spot)


    image_urls.each do |image_url|
      Image.create(spot_id: spot.id, image: image_url)
    end

    (3+rand(6)).times do
      MenuItem.create(create_menu_item(spot))
    end

    puts "Seeded Spot ##{n * 10 + index+1}: #{spot[:name]} with #{image_urls.count} images"

  end
end
