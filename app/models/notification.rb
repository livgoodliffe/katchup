class Notification < ApplicationRecord
  belongs_to :user

  enum variety: %i[friend catchup guest]
end
