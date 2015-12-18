# make first user admin
puts 'make first user admin'
user = User.first
user.update(admin: true)

# make anonymous user
puts 'make anonymous user'
user = User.new
user.name = 'Anonymous'
user.email = 'anonymous@example.com'
user.password = 'taawktljasktlw4aagljfjksdfj'
user.password_confirmation = 'taawktljasktlw4aagljfjksdfj'
user.save
