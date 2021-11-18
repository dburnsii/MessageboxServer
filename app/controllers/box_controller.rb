class BoxController < ApplicationController
  before_action :authenticate_user!, only: [:register, :submit]
  before_action :authenticate_box, only: [:activate, :update]

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
    firmware_name = params[:firmware]
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
      firmware = Firmware.find_by version: firmware_name
      if !firmware
        puts "Invalid firmware: " + firmware_name
      else
        box.firmware_id = firmware.id
        box.target_firmware_id = firmware.id
      end
      box.save
    end
    response.set_header("code", box.activation_code)
    render html: "waiting"
  end

  def update
    current_firmware = request.headers["HTTP_X_ESP8266_VERSION"]
    if !@box.has_attribute? "firmware" or current_firmware != @box.firmware.version
      puts "Updating current firmware."
      puts current_firmware
      current_firmware_ref = Firmware.find_by version: current_firmware
      if current_firmware_ref
        @box.firmware_id = current_firmware_ref.id
        @box.save
      else
        puts "Running invalid firmware: " + current_firmware
      end
    end

    puts @box.firmware_id
    puts @box.target_firmware_id
    if @box.firmware_id != @box.target_firmware_id
      target_firmware = Firmware.find_by id: @box.target_firmware_id
      puts "Time for an update!"
      send_data target_firmware.file, :filename => "firmware.bin"
      headers['Content-Length'] = target_firmware.file.size
    else
      puts "Up to date."
      render :html => "Up to date", :status => 304
    end
  end

  def authenticate_box
    @box = authenticate_with_http_basic { |u, p| Box.find_by key: bin_to_hex(u) }
  end

  def bin_to_hex(s)
    s.each_byte.map { |b| b.to_s(16) }.join
  end
end
