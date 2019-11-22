require 'yelp'

Yelp.client.configure do |config|
  config.consumer_key = YELP_CLIENT
  config.consumer_secret = YELP_CLIENT
  config.token = YELP_API
  config.token_secret = YELP_API
end

Yelp.client.search('San Francisco', { term: 'food' })
