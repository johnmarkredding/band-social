User.destroy_all
Band.destroy_all

user = User.new(name: 'John')
user.save
user = User.find_by_name('John')

user_band = user.bands.new(name: 'Band #1', description: 'My first band')

if user_band.save
  puts "Done"
else
  puts "Incomplete"
end
