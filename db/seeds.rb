# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Community
community = Community.create(name: "Swan's Way", cap: 250, time_zone: 'Pacific Time (US & Canada)', rotation_length: 13)


puts "#{Community.count} Community created"

# Units / Residents
('A'..'Z').to_a.each_with_index do |letter, index|
  unless letter == 'O' || letter == 'I'
    unit = Unit.create(name: letter)
    Resident.create(name: Faker::Name.name,
                    multiplier: 1, unit_id: unit.id)
    Resident.create(name: Faker::Name.first_name,
                    multiplier: 2, unit_id: unit.id)

    if index % 5 == 0
      Resident.create(name: Faker::Name.first_name,
                      multiplier: 2, unit_id: unit.id, vegetarian: true)
    else
      Resident.create(name: Faker::Name.first_name,
                      multiplier: 2, unit_id: unit.id)
    end
  end
end

puts "#{Unit.count} Units created"
puts "#{Resident.count} Residents created"

# Meals (will be reconciled)
Meal.create_templates(Date.parse('15-12-2015'), Date.parse('15-03-2016'), 0, 0)

meal_count_1 = Meal.count
puts "#{Meal.count} Meals created"


def create_guests_and_meal_residents
  Meal.unreconciled.each do |meal|
    Resident.all.shuffle[0..(Random.rand(8..21))].each_with_index do |resident, index|
      if index % 10 == 0
        guest = Guest.new(name: "Guest #{resident.id}",
                     multiplier: 2,
                     resident_id: resident.id,
                     meal_id: meal.id)

        guest.vegetarian = true if index % 20 == 0
        guest.save
      else
          meal_resident = MealResident.new(resident_id: resident.id,
                              meal_id: meal.id,
                              multiplier: resident.multiplier)

          meal_resident.vegetarian = true if index % 5 == 0
          meal_resident.late       = true if index % 7 == 0
          meal_resident.save
      end
    end
  end
end

# MealResidents & Guests
create_guests_and_meal_residents

guest_count_1 = Guest.count
puts "#{Guest.count} Guests created"

meal_resident_count_1 = MealResident.count
puts "#{MealResident.count} MealResidents created"

# Bills
Meal.unreconciled.each_with_index do |meal, index|
  ids = Resident.pluck(:id).shuffle[0..1]
  if index % 2 == 0
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount_cents: (2500..3500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount_cents: (3500..4500).to_a.shuffle[0])
  else
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount_cents: (5500..6500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount_cents: (6500..7500).to_a.shuffle[0])
  end
end

bill_count_1 = Bill.count
puts "#{Bill.count} Bills created"

# Reconciliation
Reconciliation.create
puts "#{Reconciliation.count} Reconciliation created"


# Meals (will not be reconciled)
Meal.create_templates(Date.parse('16-03-2016'), Date.parse('15-05-2016'), 0, 0)


# MealResidents & Guests
create_guests_and_meal_residents

puts "#{Guest.count - guest_count_1} more Guests created"
puts "#{MealResident.count - meal_resident_count_1} more MealResidents created"

# Bills
Meal.unreconciled.each_with_index do |meal, index|
  ids = Resident.pluck(:id).shuffle[0..1]
  if index % 3 == 0
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount_cents: (2500..3500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount_cents: (3500..4500).to_a.shuffle[0])
  elsif index % 4 == 0
    Bill.create(meal_id: meal.id, resident_id: ids[0],
                amount_cents: (5500..6500).to_a.shuffle[0])
    Bill.create(meal_id: meal.id, resident_id: ids[1],
                amount_cents: (6500..7500).to_a.shuffle[0])
  end
end

puts "#{Bill.count - bill_count_1} more Bills created"

# Set description
Meal.all.each_with_index do |meal, index|
  if index % 2 == 0
    meal.update(description: 'Tofu tacos, Beet Salad, Sourdough Rolls, Chocolate Cake')
  else
    meal.update(description: 'Sloppy Joe, Ceasar Salad, Whole Wheat Bread, Strawberries')
  end
end


# Set Max
Meal.all.each_with_index do |meal, index|
  next if meal.bills.count == 0
  meal.closed = true
  meal.extras = (1..5).to_a.shuffle.first if index % 2 == 0
  meal.save
end
