require 'rmagick'
require 'base64'
include Magick

class MessageController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    recp = User.find_by username: params[:recipient]
    if !recp
      redirect_to message_new_path, alert: "User not found"
      return
    end
    body = params[:message][:image]
    message = Message.new
    message.body = body
    message.recipient = recp
    message.sender = current_user
    message.save
    redirect_to root_path, notice: "Message sent!"
  end

  def read
    box = Box.find_by key: params[:key]
    if !box
      puts "No box"
      response.set_header "status", "No Box"
      render html: "No box"
      return
    end

    messages =  Message.where recipient_id: box.user_id, received: false
    message = messages.order(:created_at).first
    if message
      decoded = Base64.decode64(message.body)
      puts message.body
      response.set_header "sender", User.find(message.sender_id).email
      response.set_header "status", "New Message"
      response.set_header "Content-Length", decoded.size
      send_data decoded, type: "application/octet-stream"
      message.update received: true
    else
      response.set_header "status", "No Messages"
      render html: "No Messages"
    end
  end
end
