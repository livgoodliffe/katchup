class CatchupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
    # CatchupChannel.broadcast_to("chat_#{params[:room]}", 'Hello')
    # CatchupChannel.broadcast_to(current_user, title: 'New things!', body: 'All the news fit to print')
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
