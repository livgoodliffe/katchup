class Favourite < ApplicationRecord
  include PublicActivity::Model
  tracked except: [:destroy, :create], owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  belongs_to :spot
end
