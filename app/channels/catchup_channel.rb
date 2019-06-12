class CatchupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    return unless data["request"] == "list"

    Notification.where(user_id: current_user.id).each do |notification|
      if notification.dismissed == false
        ActionCable.server.broadcast("catchup#{current_user.id}", JSON.parse(notification.content))
      end
    end
  end
end
