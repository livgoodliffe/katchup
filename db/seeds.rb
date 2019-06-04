# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'

# return unless Rails.env.development?

RESTAURANTS = []

BASE_SELECTOR='.result'
NAME_SELECTOR='.detail a h4'
LOCATION_SELECTOR='.detail .subTitle'
DESCRIPTION_SELECTOR='.detail .snippet'
IMAGE_SELECTOR='img'

BASE_URL='https://whatson.melbourne.vic.gov.au'

BASE_RESTAURANT_URL='https://whatson.melbourne.vic.gov.au/diningandnightlife/restaurants/allrestaurants/pages/allrestaurants.aspx'
results =  Nokogiri::HTML(open(BASE_RESTAURANT_URL)).css(BASE_SELECTOR)

def getImageSrc(src)
  src.gsub('Small','Large')
end

results.each_with_index do |result, index|
  restaurant = {
    name: result.css(NAME_SELECTOR).text.strip,
    location: result.css(LOCATION_SELECTOR).text.strip,
    description: result.css(DESCRIPTION_SELECTOR).text.strip,
    image: "#{BASE_URL}#{getImageSrc(result.css(IMAGE_SELECTOR).attr('src').text)}"

  }
  puts "Adding restaurant #{index+1}"
  RESTAURANTS << restaurant
end

Spot.destroy_all
Spot.create(RESTAURANTS)
