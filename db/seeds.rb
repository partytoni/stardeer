# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:"Admin",
             email: "martemmuccio@gmail.com",
             password:              "password",
             password_confirmation: "password",
             superadmin_role: true,
             confirmed_at: DateTime.now)
User.create!(name: "Moderator",
             email: "ant.mar94@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             supervisor_role: true,
             confirmed_at: DateTime.now)
User.create!(name: "Antonio Memma",
             email: "antmem@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             confirmed_at: DateTime.now)
