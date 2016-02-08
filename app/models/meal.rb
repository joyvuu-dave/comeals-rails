# == Schema Information
# Schema version: 20160202150722
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Meal < ApplicationRecord
  attr_readonly :cap

  has_many :bills, dependent: :destroy
  has_many :meal_residents, inverse_of: :meal, dependent: :destroy
  has_many :guests, inverse_of: :meal, dependent: :destroy
  has_many :residents, through: :meal_residents

  validates :date, uniqueness: true

  accepts_nested_attributes_for :guests, allow_destroy: true

  def cap
    read_attribute(:cap) || Float::INFINITY
  end

  # DERIVED DATA
  def multiplier
    meal_residents_multiplier + guests_multiplier
  end

  def attendees
    meal_residents_count + guests_count
  end

  def chargeable_unit_cost
    if attendees == 0
      0
    else
      fraction = cost / multiplier.to_f
      [(fraction.nan? ? 0 : fraction).ceil, cap].min
    end
  end

  def is_subsidized
    chargeable_unit_cost * multiplier - cost < 0
  end
end
