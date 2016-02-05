# == Schema Information
# Schema version: 20160202150722
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
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

class Resident < ApplicationRecord
  belongs_to :unit
  has_many :bills, dependent: :destroy
  has_many :meal_residents, dependent: :destroy
  has_many :meals, through: :meal_residents
  has_many :guests, dependent: :destroy

  validates :name, uniqueness: true
  validates :multiplier, numericality: { only_integer: true }

  # DERIVED DATA
  def bill_reimbursements
    bills.reduce(0) { |sum, bill| sum + bill.reimburseable_amount }
  end

  def meal_resident_costs
    meal_residents.reduce(0) { |sum, meal_resident| sum + meal_resident.cost }
  end

  def guest_costs
    guests.reduce(0) { |sum, guest| sum + guest.cost }
  end

  def balance
    bill_reimbursements - meal_resident_costs - guest_costs
  end
end
