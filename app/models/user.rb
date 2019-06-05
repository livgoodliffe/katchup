class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :favourites
  has_many :wishlists

  has_many :favourite_spots, through: :favourites, source: :spot
  has_many :wishlist_spots, through: :wishlists, source: :spot

  has_many :friends, dependent: :destroy
  has_many :pending_friends, through: :friends, source: :friend

  def reviewed_spot?(spot)
    reviews.where(spot: spot).any?
  end

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

  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def is_following?(user_id)
    relationship = Follow.find_by(follower_id: id, following_id: user_id)
    return true if relationship
  end
end
