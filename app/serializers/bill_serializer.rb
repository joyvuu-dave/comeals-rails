# == Schema Information
# Schema version: 20160202150722
#
# Table name: bills
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  amount      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
             :start,
             :url

  def title
    "Cook\n#{object.resident.name} - $#{sprintf('%0.02f', (object.amount/100.to_f))}"
  end

  def start
    object.meal.date
  end

  def url
    "/bills/#{object.id}/edit"
  end
end
