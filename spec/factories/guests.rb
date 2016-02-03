# == Schema Information
# Schema version: 20160202150722
#
# Table name: guests
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  multiplier  :integer          default(2), not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_guests_on_meal_id      (meal_id)
#  index_guests_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_47de94cfe5  (meal_id => meals.id)
#  fk_rails_96051864fd  (resident_id => residents.id)
#

FactoryGirl.define do
  factory :guest do
    meal
    resident
    multiplier 2
    name "MyString"
  end
end
