# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def clean_db
  User.delete_all
end

def create_users
  User.create!(email: "riri@mail.com", password: "azerty", nickname: "Riri")
  User.create!(email: "fifi@mail.com", password: "azerty", nickname: "Fifi")
  User.create!(email: "loulou@mail.com", password: "azerty", nickname: "Loulou")
end


puts "Clean DB"
clean_db
create_users