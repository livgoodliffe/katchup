class Guest < ApplicationRecord
  belongs_to :catchup
  belongs_to :user

  enum status: [:pending, :accepted, :cancelled, :rejected]
end
