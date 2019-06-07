class Catchup < ApplicationRecord
  # the owner of the event
  belongs_to :user
  belongs_to :spot

  # an event has 0..n guests coming to it
  has_many :guests, dependent: :destroy

  # ??
  # has_many :saved_users, through: :guests, source: :user


  enum status: [:pending, :accepted, :cancelled, :rejected]

end
