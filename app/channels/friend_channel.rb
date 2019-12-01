class FriendChannel < ApplicationCable::Channel
  def subscribed
     stream_from "#{params[:room]}#{current_user.id}"
  end

  def unsubscribed
  end
end
