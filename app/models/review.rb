class Review < ApplicationRecord
  include PublicActivity::Model
  tracked except: :destroy, owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  belongs_to :spot

  # validate rating is 1-5

  mount_uploader :image, PhotoUploader

  def self.ordered_by_date
    order(created_at: :desc)
  end
end
