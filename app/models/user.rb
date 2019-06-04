class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews

  def reviewed_spot?(spot)
    reviews.where(spot: spot).any?
  end

  has_many :spots
  has_many :favourites
  has_many :wishlists

  def favourited_spot?(spot)
    favourites.where(spot: spot).any?
  end

  def find_favourite(spot)
    favourites.where(spot: spot).first
  end

  def wishlisted_spot?(spot)
    wishlists.where(spot: spot).any?
  end

  def find_wishlist(spot)
    wishlists.where(spot: spot).first
  end
end
