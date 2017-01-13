# == Schema Information
# Schema version: 20170112210803
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  bill_costs :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_name     (name) UNIQUE
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (unit_id => units.id)
#

class Resident < ApplicationRecord
  belongs_to :unit
  has_many :bills, dependent: :destroy
  has_many :meal_residents, dependent: :destroy
  has_many :meals, through: :meal_residents
  has_many :guests, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :multiplier, numericality: { only_integer: true }

  # DERIVED DATA
  def bill_reimbursements
    return 0 if Meal.unreconciled.count == 0
    bills.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).reduce(0) { |sum, bill| sum + bill.reimburseable_amount }
  end

  def meal_resident_costs
    return 0 if Meal.unreconciled.count == 0
    meal_residents.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).reduce(0) { |sum, meal_resident| sum + meal_resident.cost }
  end

  def guest_costs
    return 0 if Meal.unreconciled.count == 0
    guests.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).reduce(0) { |sum, guest| sum + guest.cost }
  end

  def balance
    return 0 if Meal.unreconciled.count == 0
    bill_reimbursements - meal_resident_costs - guest_costs
  end

  def meals_attended
    return 0 if Meal.unreconciled.count == 0
    meal_residents.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).count
  end
end
