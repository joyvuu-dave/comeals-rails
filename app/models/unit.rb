# == Schema Information
# Schema version: 20160131201418
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ApplicationRecord
  has_many :residents, dependent: :destroy
  validates :name, uniqueness: true

  # DERIVED DATA
  def balance
    residents.reduce(0) { |sum, resident| sum + resident.balance }
  end
end
