# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Clearing the database'

StockDayInfo.destroy_all
Acquisition.destroy_all
FollowedStock.destroy_all
Stock.destroy_all
User.destroy_all

puts "Creating Users"

luis = User.create!(email: 'luis@gmail.com', password: '123456')
victor = User.create!(email: 'victor@gmail.com', password: '123456')
noam = User.create!(email: 'noam@gmail.com', password: '123456')
jean = User.create!(email: 'jean@gmail.com', password: '123456')

puts "Creating Stock"

tsla = Stock.create!(ticker: 'TSLA', name: 'Tesla'),
amazon = Stock.create!(ticker: 'AMZN', name: 'Amazon'),
googl = Stock.create!(ticker: 'GOOGL', name: 'Google'),
facebook = Stock.create!(ticker: 'FB', name: 'Facebook')

users = [luis, victor, noam, jean]
stocks = [tsla, amazon, googl, facebook]

puts "Creating Stock Day Info"

10.times do
  StockDayInfo.create!(stock: stocks[rand(1...4)], closing_price: rand(1..100), closing_date: Faker::Date.in_date_period)
end

puts "Creating Followed Stocks"

10.times do
  FollowedStock.create!(stock: stocks[rand(1...4)], user: users[rand(1...4)], name: Faker::Name.name)
end

puts "Creating Acquisitions"

10.times do
  Acquisition.create!(stock: stocks[rand(1...4)], user: users[rand(1...4)], date_bought: Faker::Date.in_date_period, amount_bought: rand(1..100), value_bought: rand(10..100))
end
