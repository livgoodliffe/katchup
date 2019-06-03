class CatchUpUser < ApplicationRecord
  belongs_to :catchup
  belongs_to :user
end
