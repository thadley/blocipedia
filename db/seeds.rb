require 'faker'

5.times do
  password = Faker::Lorem.characters(10)
  user = User.new(
    username: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  user.skip_confirmation!
  user.save
end

puts "Seed finished"