class Spot < ApplicationRecord

  has_many :reviews
  has_many :friends
  has_many :images

  def average_rating
    reviews.average(:rating)
  end

  geocoded_by :address

  after_validation :geocode, if: :will_save_change_to_address?

end
