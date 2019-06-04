class Spot < ApplicationRecord

  has_many :reviews

  def average_rating
    reviews.average(:rating)
  end

  geocoded_by :location

  after_validation :geocode, if: :will_save_change_to_location?

end
