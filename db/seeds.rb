puts("Creating Projects")
puts("=================")
20.times do |time|
  if time % 7 == 0
    p = Project.create(name: Faker::App.name)
  else
    p = Project.create(name: Faker::App.name, description: Faker::Lorem.sentence)
  end
  p.entries.create(hours: rand(23), minutes: rand(59), comment: Faker::Lorem.sentence)
end
puts(" => Projects created √")