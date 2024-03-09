class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params['chat_id']}"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_data(data)
    info = data['info']
    ActionCable.server.broadcast("chat_#{data['chat_id']}", info)
  end
end
