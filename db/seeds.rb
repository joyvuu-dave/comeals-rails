# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Community
community = Community.create(name: "Swan's Way", cap: 250)

puts "#{Community.count} Community created"

# Units / Residents
('A'..'Z').to_a.each_with_index do |letter, index|
  unit = Unit.create(name: letter)
  Resident.create(name: "Child #{(index + 1) * 3 - 2}",
                  multiplier: 1, unit_id: unit.id)
  Resident.create(name: "Adult #{(index + 1) * 3 - 1}",
                  multiplier: 2, unit_id: unit.id)
  Resident.create(name: "Adult #{(index + 1) * 3}",
                  multiplier: 2, unit_id: unit.id)
end

puts "#{Unit.count} Units created"
puts "#{Resident.count} Residents created"

# Meals
require 'date'
now = Date.today
(1..365).to_a.each do |num|
  Meal.create(date: now - num, community_id: community.id)
end

puts "#{Meal.count} Meals created"

# MealResidents & Guests
Meal.all.each do |meal|
  Resident.all.shuffle[0..20].each_with_index do |resident, index|
    if index % 10 === 0
      Guest.create(name: "Guest #{resident.id}",
                   multiplier: 2,
                   resident_id: resident.id,
                   meal_id: meal.id)
    else
      MealResident.create(resident_id: resident.id,
                          meal_id: meal.id,
                          multiplier: resident.multiplier)
    end
  end
end

puts "#{Guest.count} Guests created"
puts "#{MealResident.count} MealResidents created"

# Bills
Meal.all.each_with_index do |meal, index|
  ids = Resident.pluck(:id).shuffle[0..1]
  if index % 2 == 0
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount: (2500..3500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount: (3500..4500).to_a.shuffle[0])
  else
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount: (5500..6500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount: (6500..7500).to_a.shuffle[0])
  end
end

puts "#{Bill.count} Bills created"
