class MessageController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] 

  def new
  end

  def create

    recp = User.find_by email: params[:recipient]
    body = params[:message]
    if recp
      message = Message.new
      message.body = body
      message.recipient_id = recp.id
      message.sender_id = current_user.id
      message.save
      puts "Sending message! :D"
    end
  end

  def read
    box = Box.find_by key: params[:key]
    if !box
      puts "No box"
      render html: "No box"
      return
    end

    #if box.user_id != params[:user]
    #  puts "Invalid user id"
    #  render html: "Invalid"
    #  return
    #end

    messages =  Message.where recipient_id: box.user_id, received: false
    message = messages.order(:created_at).first
    if message
      response.set_header "sender", User.find(message.sender_id).email
      render html: message.body
      message.update received: true
    else
      render html: "No Messages"
    end
  end
end
