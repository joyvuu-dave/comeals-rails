# == Schema Information
# Schema version: 20160202150722
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_units_on_name  (name) UNIQUE
#

class Unit < ApplicationRecord
  has_many :residents, dependent: :destroy
  validates :name, uniqueness: true, presence: true

  # DERIVED DATA
  def balance
    return 0 if Meal.unreconciled.count == 0
    residents.reduce(0) { |sum, resident| sum + resident.balance }
  end

  def meals_cooked
    return 0 if Meal.unreconciled.count == 0
    residents.reduce(0) { |sum, resident| sum + resident.bills.joins(:meal).where({:meals => {:reconciliation_id =>  nil}}).count }
  end
end
