class ChatController < WebsocketRails::BaseController
  def new_message
    # Here we call the rails-websocket broadcast_message method
    broadcast_message :new_message, 'Echo: ' + message
  end
end