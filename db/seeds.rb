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

DETAIL_LINK_SELECTOR='.detail a'
DETAIL_LOCATION_SELECTOR='.detailsContainer h2+p'
DETAIL_DESCRIPTION_SELECTOR='.detailsContainer h4+p'
DETAIL_HOURS_SELECTOR='.detailsContainer .hanging.noindex'
DETAIL_IMAGES_SELECTOR='.nivoSlider img'

BASE_URL='https://whatson.melbourne.vic.gov.au'

BASE_RESTAURANT_URL='https://whatson.melbourne.vic.gov.au/diningandnightlife/restaurants/allrestaurants/pages/allrestaurants.aspx'

Image.destroy_all
Spot.destroy_all

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
  spot_detail_location_raw = result_detail_doc.css(DETAIL_LOCATION_SELECTOR).text.gsub(/([^ ]{1})Melbourne/,'\1 Melbourne')
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
  end
end
