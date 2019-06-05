class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  mount_uploader :image, PhotoUploader

  def self.ordered_by_date
    order(created_at: :desc)
  end
end
