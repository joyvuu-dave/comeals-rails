# == Schema Information
# Schema version: 20160131201418
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

class Resident < ApplicationRecord
  belongs_to :unit
  has_many :bills
  has_many :attendances

  validates :name, uniqueness: true
  validates :multiplier, numericality: { only_integer: true }

  # DERIVED DATA
  def bill_costs
    bills.pluck(:amount).reduce(&:+)
  end

  def bill_reimbursements
    bills.reduce(0) { |sum, bill| sum + bill.reimburseable_amount }
  end

  def attendance_costs
    attendances.reduce(0) { |sum, attendance| sum + attendance.cost }
  end

  def balance
    bill_reimbursements - attendance_costs
  end
end
