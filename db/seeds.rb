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

BASE_SELECTOR='.result'
NAME_SELECTOR='.detail a h4'
# LOCATION_SELECTOR='.detail .subTitle'
DESCRIPTION_SELECTOR='.detail .snippet'
IMAGE_SELECTOR='img'

DETAIL_LINK_SELECTOR='.detail a'
DETAIL_LOCATION_SELECTOR='.detailsContainer h2+p'

BASE_URL='https://whatson.melbourne.vic.gov.au'

BASE_RESTAURANT_URL='https://whatson.melbourne.vic.gov.au/diningandnightlife/restaurants/allrestaurants/pages/allrestaurants.aspx'

Spot.destroy_all

def getImageSrc(src)
  src.gsub('Small','Large')
end

70.times do |n|
  results =  Nokogiri::HTML(open("#{BASE_RESTAURANT_URL}?start=#{n*10}")).css(BASE_SELECTOR)

  results.each_with_index do |result, index|
    restaurant_detail_url = result.css(DETAIL_LINK_SELECTOR).attr('href')

    restaurant_detail_location_initial = Nokogiri::HTML(open("#{BASE_URL}#{restaurant_detail_url}")).css(DETAIL_LOCATION_SELECTOR).text.gsub(/([^ ]{1})Melbourne/,'\1 Melbourne')
    puts restaurant_detail_location_initial
    restaurant_detail_location_cleaned_up = restaurant_detail_location_initial
    .gsub("\n"," ")
    .gsub(/(\(.*\))/,'')
    .gsub(/([a-z])([A-Z])/,'\1 \2')
    .gsub(/([a-z])(\d)/,'\1 \2')
    .gsub(/(\d)([A-Z])/,'\1 \2')
    .gsub('  ', ' ').strip


    restaurant = {
      name: result.css(NAME_SELECTOR).text.strip,
      location: restaurant_detail_location_cleaned_up,
      description: result.css(DESCRIPTION_SELECTOR).text.strip,
      image: "#{BASE_URL}#{getImageSrc(result.css(IMAGE_SELECTOR).attr('src').text)}"

    }
    puts "Adding #{n * 10 + index+1}: #{result.css(NAME_SELECTOR).text.strip} @ #{restaurant_detail_location_cleaned_up}"
    Spot.create(restaurant)
  end
end
