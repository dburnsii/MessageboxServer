class AddFirmwareRefToBox < ActiveRecord::Migration[6.0]
  def change
    add_reference :boxes, :firmware, null: false, foreign_key: { to_table: :firmwares }
    add_reference :boxes, :target_firmware, null: false, foreign_key: { to_table: :firmwares }
  end
end
