require 'digest'

class FirmwareController < ApplicationController
  before_action :authenticate_admin_user!

  def new
  end

  def create
    puts "Creating firmware!"
    version = params[:version]
    file = params[:file]
    if Firmware.find_by version: version
      puts "Firmware exists"
    else
      puts "Good!"
      file_contents = file.read()
      firmware = Firmware.create(version: version, file: file_contents)
      md5 = Digest::MD5.new
      md5.update file_contents
      digest = md5.hexdigest
      puts "MD5:"
      puts digest
      firmware.checksum = digest
      firmware.save
    end
    render html: "good."
  end
end
