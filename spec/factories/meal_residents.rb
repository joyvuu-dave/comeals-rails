# == Schema Information
# Schema version: 20160202144504
#
# Table name: meal_residents
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  multiplier  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_meal_residents_on_meal_id                  (meal_id)
#  index_meal_residents_on_meal_id_and_resident_id  (meal_id,resident_id)
#  index_meal_residents_on_resident_id              (resident_id)
#
# Foreign Keys
#
#  fk_rails_7bb4e17f2a  (resident_id => residents.id)
#  fk_rails_c5855254a4  (meal_id => meals.id)
#

FactoryGirl.define do
  factory :meal_resident do
    meal
    resident
    multiplier 2
  end
end
