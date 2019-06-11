class CatchupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
