ActiveAdmin.register Firmware do

  permit_params :version, :checksum, :file

  index do |f|
    column :id
    column :version
    column :checksum
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.text_field :version
    f.file_field :file
    f.submit
  end

end
