# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dev_firmware = Firmware.create(version: "0.0.0", checksum: "d41d8cd98f00b204e9800998ecf8427e", file: "test")
dev_firmware = Firmware.create(version: "0.1.0", checksum: "d41d8cd98f00b204e9800998ecf8427e", file: "test")
AdminUser.create!(email: 'admin@example.com', username: 'admin', password: 'password', password_confirmation: 'password') if Rails.env.development?
