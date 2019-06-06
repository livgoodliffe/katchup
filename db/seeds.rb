# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'faker'

User.destroy_all
Friendship.destroy_all

SEED_FRIEND_COUNT = 10
SEED_FRIENDSHIP_COUNT = 50

SEED_FRIEND_COUNT.times do |n|
  user = User.new
  user.email = Faker::Internet.email
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.password = "Password123"
  user.remote_avatar_url = Faker::Avatar.image
  user.save!
  puts "Seeded User: ##{n+1}"
end

p "Adding 3 wishlists and 3 favourites to all users.."

User.all.each do |user|
  3.times {
    Wishlist.create(user: user, spot: Spot.all.sample)
  }
  3.times {
    Favourite.create(user: user, spot: Spot.all.sample)
  }
end

p "added.."

500.times {
SEED_FRIENDSHIP_COUNT.times do |n|
  friend = Friendship.new
  friend.user_id = rand(1..SEED_FRIEND_COUNT)
  friend.friend_id = rand(1..SEED_FRIEND_COUNT)
  puts "Attempting Friendship: ##{n+1}..."
  unless Friendship.exists?(user_id: friend.user_id, friend_id: friend.friend_id )
    friend.save!
    puts "Friendship seeded"
  end
end

# return unless Rails.env.development?

BASE_SELECTOR='.result'
NAME_SELECTOR='.detail a h4'

DETAIL_LINK_SELECTOR='.detail a'
DETAIL_LOCATION_SELECTOR='.detailsContainer h2+p'
DETAIL_DESCRIPTION_SELECTOR='.detailsContainer h4+p'

DETAIL_HOURS_SELECTOR='.detailsContainer .hanging'

DETAIL_IMAGES_SELECTOR='.nivoSlider img'

BASE_URL='https://whatson.melbourne.vic.gov.au'

BASE_RESTAURANT_URL='https://whatson.melbourne.vic.gov.au/diningandnightlife/restaurants/allrestaurants/pages/allrestaurants.aspx'

Image.destroy_all
Spot.destroy_all

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
    puts "Image #{index}: #{image_url}"
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

  puts
  puts "raw location: #{spot_detail_location_raw}"
  puts "saved location: #{spot_detail_location}"
  puts "saved address: #{spot_detail_address}"

  { location: spot_detail_location,
    address: spot_detail_address}
end

def get_description(result_detail_doc)
  description = result_detail_doc.css(DETAIL_DESCRIPTION_SELECTOR).text
  .gsub('.','. ')
  .gsub('  ',' ').strip
  puts "description: #{description}"

  description
end

def get_hours(result_detail_doc)
  hours = result_detail_doc.css(DETAIL_HOURS_SELECTOR).text
  .gsub(/([a-z])([A-Z])/, '\1<br>\2')

  puts "hours: #{hours}"
  hours
end

70.times do |n|

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

    puts "Adding #{n * 10 + index+1}: #{spot[:name]}"

    spot = Spot.create(spot)

    image_urls.each do |image_url|
      Image.create(spot_id: spot.id, image: image_url)
    end

    (3+rand(6)).times do
      MenuItem.create(create_menu_item(spot))
    end
  end
end
