# == Schema Information
# Schema version: 20160301173036
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
#  fk_rails_a4b9083e79  (meal_id => meals.id)
#  fk_rails_d7e3fd1337  (resident_id => residents.id)
#

class Bill < ApplicationRecord
  belongs_to :meal
  belongs_to :resident

  counter_culture :meal, column_name: 'cost', delta_column: 'amount_cents'
  counter_culture :resident, column_name: 'bill_costs', delta_column: 'amount_cents'

  validates :meal, presence: true
  validates :resident, presence: true
  validates :amount_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  monetize :amount_cents

  # DERIVED DATA
  def reimburseable_amount
    if meal.subsidized?
      cost_difference = meal.cost - meal.cap * meal.multiplier
      amount_cents - ((amount_cents / meal.cost.to_f) * cost_difference).ceil
    else
      amount_cents
    end
  end
end
