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

class BillSerializer < ActiveModel::Serializer
  cache key: 'bill'
  attributes :title,
             :header,
             :body,
             :start,
             :end,
             :url

  def title
    "Unit #{object.resident.unit.name}"
  end

  def header
    "Cook"
  end

  def body
    "#{object.resident.name} - $#{sprintf('%0.02f', (object.amount_cents/100.to_f))}"
  end

  def start
    object.meal.date
  end

  def end
    object.meal.date
  end

  def url
    "/meals/#{object.meal.id}"
  end
end
