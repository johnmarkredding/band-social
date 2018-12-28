User.destroy_all
Band.destroy_all

user = User.create(name: "Coy Joe", username:"joey", password: "cow")
jms = Band.new(name: "Jams", description: "Its our first band", manager_id: user.id)
if jms.save
  puts "Done"
else
  puts "Incomplete"
end
