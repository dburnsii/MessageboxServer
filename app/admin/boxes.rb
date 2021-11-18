ActiveAdmin.register Box do
  permit_params :user_id, :key, :activation_code, :firmware_id, :target_firmware_id


  index do |f|
    column :id
    column :user_id
    column :key
    column :activation_code
    column :firmware_id
    column :target_firmware_id
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.label :key
    f.text_field :key
    f.label :user
    f.collection_select(:user_id, User.all, :id, :username)
    f.label :activation_code
    f.text_field :activation_code
    f.collection_select(:firmware_id, Firmware.all, :id, :version)
    f.collection_select(:target_firmware_id, Firmware.all, :id, :version)
    f.submit
  end

end
