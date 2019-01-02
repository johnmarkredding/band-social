User.destroy_all
Band.destroy_all
Membership.destroy_all

user = User.create(name: 'John', username: "johnny", password: "nice")

user_band = Band.new(name: 'Band #1', description: 'My first band', manager_id: user.id)

if user_band.save
  puts "Create Band"
else
  puts "Create Band Failed"
end

membership = Membership.new(band_id: user_band.id, member_id: user.id)

if membership.save
  puts "Create Membership"
  puts user.bands
  puts user_band.members
else
  puts "Create Membership Failed"
end
