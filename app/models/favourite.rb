class Favourite < ApplicationRecord
  include PublicActivity::Model
  tracked

  belongs_to :user
  belongs_to :spot
end
