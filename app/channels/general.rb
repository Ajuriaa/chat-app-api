class AvailableDriversChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'general_channel'
  end

  def unsubscribed
    stop_all_streams
  end

  def send_data(data)
    data = data['data']
    ActionCable.server.broadcast('general_channel', data)
  end
end
