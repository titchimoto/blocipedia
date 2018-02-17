20.times do
  User.create!(email: Faker::Internet.unique.email, password: "password", role: rand(0..2))
end
users = User.all

40.times do
  Wiki.create!(title: Faker::Lorem.unique.sentence(2), body: Faker::Lorem.paragraph, user: users.sample)
end
wikis = Wiki.all

test_user =   User.create!(email: "test@email.com", password: "password", role: 0)



puts "Seed Finished"
puts "#{User.count} users added"
puts "#{Wiki.count} wikis added"
