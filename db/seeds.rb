User.destroy_all
Band.destroy_all

user = User.create(name: 'John', username: "johnny", password: "nice")

user_band = Band.new(name: 'Band #1', description: 'My first band', manager_id: user.id)

if user_band.save
  puts "Done"
else
  puts "Incomplete"
end
