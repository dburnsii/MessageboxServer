class CreateFirmwares < ActiveRecord::Migration[6.0]
  def change
    create_table :firmwares do |t|
      t.string :version
      t.string :checksum
      t.binary :file

      t.timestamps
    end
  end
end
