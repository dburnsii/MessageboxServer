class ChangeMessage < ActiveRecord::Migration[6.0]
  def change
    change_column_null :messages, :sender_id, false
    change_column_null :messages, :recipient_id, false
    change_column_null :users, :username, false
  end

end
