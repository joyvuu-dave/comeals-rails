# == Schema Information
# Schema version: 20160202150722
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  community_id              :integer
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
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
  has_many :meal_residents, inverse_of: :meal, dependent: :destroy
  has_many :guests, inverse_of: :meal, dependent: :destroy
  has_many :residents, through: :meal_residents

  validates :date, presence: true
  validates :community, presence: true

  accepts_nested_attributes_for :guests, allow_destroy: true

  before_create :set_cap

  validates :date, uniqueness: true

  def set_cap
    self.cap = community.cap
  end

  def cap
    read_attribute(:cap) || Float::INFINITY
  end

  # DERIVED DATA
  def multiplier
    meal_residents_multiplier + guests_multiplier
  end

  def chargeable_unit_cost
    if meal_residents_count + guests_count == 0
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
