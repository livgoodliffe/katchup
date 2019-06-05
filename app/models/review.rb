class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  def self.ordered_by_date
    order(created_at: :desc)
  end
end
