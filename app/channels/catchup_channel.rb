class CatchupChannel < ApplicationCable::Channel
  def subscribed
    stream_from params[:room].to_s
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
