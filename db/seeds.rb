# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

def clean_db
  User.destroy_all
end

def create_users
  User.create!(email: "ia@mail.com", password: "azerty", nickname: "Ordinateur")
  User.create!(email: "riri@mail.com", password: "azerty", nickname: "Riri")
  User.create!(email: "fifi@mail.com", password: "azerty", nickname: "Fifi")
  User.create!(email: "loulou@mail.com", password: "azerty", nickname: "Loulou")

  15.times do |n|
    User.create!(email: "user_#{n}@mail.com", password: "azerty", nickname: Faker::Games::Pokemon.name )
  end
end

def game_simulation(grid)
  while grid.in_progress? && grid.unplayed_cells.count > 0
    cell = grid.unplayed_cells.sample
    player = grid.user_who_plays
    puts "#{player.nickname.capitalize} plays cells n°#{cell.position}"
    cell.update(user: player)
  end
end

def create_grids
  common_users = User.excluding(User.ia)
  common_users.first(4).each do |user|
    puts "Create grids for player #{user.nickname}"
    opponents = common_users.excluding(user)
    4.times do 
      grid = Grid.create!(user: user, opponent: opponents.sample)
      game_simulation(grid)
    end
  end
end

puts "Clean DB"
clean_db
puts "DB cleaned"

puts "Create users"
create_users
puts "#{User.count} users created"

puts "Create grids"
create_grids
puts "#{Grid.count} grids created"

