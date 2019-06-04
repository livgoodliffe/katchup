class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spots
  has_many :favourites
  has_many :wishlists

  def favourited_spot?(spot)
    favourites.where(spot: spot).any?
  end

  def wishlisted_spot?(spot)
    wishlists.where(spot: spot).any?
  end

  def find_favorite(spot)
    favourites.where(spot: spot).first
  end

  def find_wishlist(spot)
    wishlists.where(spot: spot).first
  end
end
