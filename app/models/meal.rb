# == Schema Information
# Schema version: 20160210160946
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
#  reconciliation_id         :integer
#
# Indexes
#
#  index_meals_on_reconciliation_id  (reconciliation_id)
#
# Foreign Keys
#
#  fk_rails_4ac0d4ffd3  (reconciliation_id => reconciliations.id)
#

class Meal < ApplicationRecord
  scope :unreconciled, -> { where(reconciliation_id: nil) }

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

  # Report Methods
  def self.unreconciled_ave_cost
    val = 2 * ((Meal.unreconciled.pluck(:cost).reduce(&:+).to_i / Meal.unreconciled.reduce(0) { |sum, meal| sum + meal.multiplier }.to_f) / 100.to_f)
    "$#{sprintf('%0.02f', val)}/adult"
  end

  def self.unreconciled_ave_number_of_attendees
    (Meal.unreconciled.reduce(0) { |sum, meal| sum + meal.attendees } / Meal.unreconciled.count.to_f).round(1)
  end

  def self.create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
    # Are we finished?
    return num_meals_created if start_date >= end_date

    # Is it a common dinner day?
    if [alternating_dinner_day, 2, 4].any? { |num| num == start_date.wday }
      # Flip if alternating dinner day
      if start_date.wday == alternating_dinner_day
        alternating_dinner_day = (alternating_dinner_day - 1) ** 2
      end

      if Meal.new(date: start_date, cap: Community.first.cap).save
        num_meals_created += 1
      end

      # If common dinner was on a Sunday, we
      # don't have dinner the next day
      start_date += 24.hour if start_date.wday == 0

      start_date += 24.hour
      return create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
    end

    start_date += 24.hour
    return create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
  end
end
