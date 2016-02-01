# == Schema Information
# Schema version: 20160131201418
#
# Table name: attendances
#
#  id          :integer          not null, primary key
#  name        :string
#  multiplier  :integer          not null
#  is_guest    :boolean          default(FALSE), not null
#  resident_id :integer
#  meal_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_attendances_on_meal_id      (meal_id)
#  index_attendances_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_36737571be  (resident_id => residents.id)
#  fk_rails_79aff66e8d  (meal_id => meals.id)
#

FactoryGirl.define do
  factory :attendance do
    name "MyString"
multiplier 1
is_guest false
resident nil
meal nil
  end

end
