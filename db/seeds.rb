# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Destroying data"
User.destroy_all
Event.destroy_all
Question.destroy_all

# puts "Initializing data"


# puts "Adding sample data"


# User.create [
#   {
#     email: 'manicas@digitalocean.com',
#     name: 'Mitchell Anicas',
#     location: 'Williamsburg, NY',
#     role_id: Role.find_by(name: 'admin').id
#     },
#   {
#     email: 'tyler@digitalocean.com',
#     name: 'Tyler Wolff',
#     location: 'Honolulu, HI',
#     role_id: Role.find_by(name: 'normal').id
#     }
# ]

# Event.create [
#   { user_id: User.find_by(name: 'Mitchell Anicas').id,
#     name: '6/28/2015 AMA',
#     description: 'The first AMA event.',
#     closed: false }]

# Question.create [
#   {
#     event_id: Event.find_by(name: '6/28/2015 AMA').id,
#     user_id: User.find_by(name: 'Tyler Wolff').id,
#     copy: "So what's the deal with peanut butter and jelly sandwiches? I think they're delicious!",
#     anonymous_flag: false,
#     closed: false,
#     deleted: false
#   },
#   {
#     event_id: Event.find_by(name: '6/28/2015 AMA').id,
#     user_id: User.find_by(name: 'Mitchell Anicas').id,
#     copy: "Why doesn't this app work?",
#     anonymous_flag: true,
#     closed: false,
#     deleted: false
#   },

# ]