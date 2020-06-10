class BoxController < ApplicationController
  before_action :authenticate_user!, only: [:register, :submit]

  def register
  end

  def submit
    code = params[:activation_code]
    box = Box.find_by activation_code: code
    if box
      box.update(user_id: current_user.id)
      redirect_to "/"
    else
      # TODO: Error invalid activation code toast
      render html: "Does not exist"
    end
  end

  def activate
    key = params[:key]
    box = Box.find_by key: key
    puts box
    if box
      if box.user_id
        response.set_header("user", box.user_id)
        render html: "complete"
        return
      end
    else
      box = Box.new
      box.activation_code = rand(100000..999999).to_s
      box.key = key
      box.save
    end
    response.set_header("code", box.activation_code)
    render html: "waiting"
  end
end
