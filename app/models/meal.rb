# == Schema Information
# Schema version: 20160131201418
#
# Table name: meals
#
#  id                :integer          not null, primary key
#  date              :date             not null
#  community_id      :integer
#  cap               :integer
#  attendances_count :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_meals_on_community_id  (community_id)
#
# Foreign Keys
#
#  fk_rails_0336f048cd  (community_id => communities.id)
#

class Meal < ApplicationRecord
  attr_readonly :cap
  belongs_to :community
  has_many :bills, dependent: :destroy
  has_many :attendances, dependent: :destroy
  validates :date, uniqueness: true
  validates :community, presence: true

  before_create :set_cap

  def set_cap
    self.cap = community.cap
  end

  def cap
    read_attribute(:cap) || Float::INFINITY
  end

  # DERIVED DATA
  def cost
    bills.pluck(:amount).reduce(0) { |sum, amount| sum + amount }
  end

  def multiplier
    attendances.pluck(:multiplier).reduce(0) { |sum, multiplier| sum + multiplier }
  end

  def chargeable_unit_cost
    if attendances_count == 0
      0
    else
      [(cost / multiplier.to_f).ceil, cap].min
    end
  end

  def is_subsidized
    chargeable_unit_cost * multiplier - cost < 0
  end
end
