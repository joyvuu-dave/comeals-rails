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
#  description               :text
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

class MealSerializer < ActiveModel::Serializer
  cache key: 'meal'
  attributes :title,
             :start,
             :url

  def title
    "Common Dinner\n#{object.attendees} people"
  end

  def start
    object.date
  end

  def url
    "/meals/#{object.id}/edit"
  end
end
