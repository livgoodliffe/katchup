class CatchupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:room]}#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    return unless data["request"] == "list"

    puts "received a list request"
    Notification.where(user_id: current_user.id).each do |notification|
      puts "going to send this as message to catchup#{current_user.id} JSON.parse(notification.content)"
      if notification.dismissed == false && notification.catchup?
        ActionCable.server.broadcast("catchup#{current_user.id}", JSON.parse(notification.content))
      end
    end
  end
end
