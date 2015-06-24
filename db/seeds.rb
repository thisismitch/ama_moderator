# make first user admin
puts 'make first user admin'
user = User.first
user.update(admin: true)

# puts "Adding sample data"