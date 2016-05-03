# == Schema Information
# Schema version: 20160330153936
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
#  max                       :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  reconciliation_id         :integer
#  closed                    :boolean          default(FALSE), not null
#  time_zone                 :string
#  auto_close                :boolean          default(FALSE), not null
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
             :header,
             :body,
             :start,
             :end,
             :url

  def reconciled
    object.reconciled?
  end

  def title
    object.description
  end

  def header
    'Common Dinner'
  end

  def body
    syntax = object.attendees == 1 ? "person" : "people"
    max_string = object.max ? "(#{object.max} max)" : ""
    "#{object.attendees} #{syntax} #{max_string}"
  end

  def start
    object.date
  end

  def end
    object.date
  end

  def url
    "/meals/#{object.id}"
  end
end
