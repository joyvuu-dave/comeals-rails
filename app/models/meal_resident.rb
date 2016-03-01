# == Schema Information
# Schema version: 20160301173036
#
# Table name: meal_residents
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  multiplier  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  vegetarian  :boolean          default(FALSE), not null
#  late        :boolean          default(FALSE), not null
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

class MealResident < ApplicationRecord
  belongs_to :meal, inverse_of: :meal_residents
  belongs_to :resident

  before_validation :set_multiplier

  counter_culture :meal
  counter_culture :meal, column_name: 'meal_residents_multiplier', delta_column: 'multiplier'

  validates :meal, presence: true
  validates :resident, presence: true
  validates :multiplier, numericality: { only_integer: true }

  def set_multiplier
    self.multiplier = resident.multiplier
  end

  def cost
    meal.chargeable_unit_cost * multiplier
  end
end
