ActiveAdmin.register Message do

  index do |f|
    selectable_column
    column :id
    column :recipient
    column :sender
    column :created_at
    column :updated_at
    column :received
    actions
  end

end
