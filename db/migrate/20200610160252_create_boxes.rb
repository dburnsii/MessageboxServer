class CreateBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :boxes do |t|
      t.references :user, index: true, foreign_key: true
      t.text :key
      t.string :activation_code

      t.timestamps
    end
  end
end
