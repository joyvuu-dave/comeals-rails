# == Schema Information
# Schema version: 20160131201418
#
# Table name: bills
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  amount      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_bills_on_meal_id      (meal_id)
#  index_bills_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_a4b9083e79  (meal_id => meals.id)
#  fk_rails_d7e3fd1337  (resident_id => residents.id)
#

FactoryGirl.define do
  factory :bill do
    meal nil
resident nil
amount 1
  end

end
