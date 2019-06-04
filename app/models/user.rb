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

  def find_favourite(spot)
    favourites.where(spot: spot).first
  end
end
