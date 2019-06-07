class Wishlist < ApplicationRecord
  include PublicActivity::Model
  tracked except: :destroy, owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  belongs_to :spot
end
