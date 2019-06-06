class FriendshipsController < ApplicationController

  def index
    @friends = Friendship.where(user_id: current_user)
  end

end
