# == Schema Information
# Schema version: 20170112210803
#
# Table name: bills
#
#  id              :integer          not null, primary key
#  meal_id         :integer
#  resident_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#
# Indexes
#
#  index_bills_on_meal_id      (meal_id)
#  index_bills_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (resident_id => residents.id)
#

class Bill < ApplicationRecord
  belongs_to :meal
  belongs_to :resident

  counter_culture :meal
  counter_culture :meal, column_name: 'cost', delta_column: 'amount_cents'
  counter_culture :resident, column_name: 'bill_costs', delta_column: 'amount_cents'

  validates :meal, presence: true
  validates :resident, presence: true
  validates :amount_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :bill_can_be_created, on: :create
  validate :amount_cents_is_within_meal_limits

  monetize :amount_cents

  def bill_can_be_created
    unless meal.can_add_bill?
      errors.add(:meal, "Can't add another bill until people sign up.") and return if meal.attendees == 0
      errors.add(:meal, "Meal cost already exceeds cap.")
    end
  end

  def amount_cents_is_within_meal_limits
    errors.add(:amount_cents, "Amount exceeds limits.") if amount_cents > meal.max_bill_amount
  end

  # DERIVED DATA
  def reimburseable_amount
    return meal.cost - meal.cap * meal.multiplier if meal.subsidized?

    adj_amount = amount_cents
    while adj_amount % meal.multiplier != 0
      adj_amount += 1
    end
    adj_amount
  end

end
