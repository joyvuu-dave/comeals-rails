# == Schema Information
# Schema version: 20160309185245
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
#  vegetarian :boolean          default(FALSE), not null
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

class ResidentSerializer < ActiveModel::Serializer
  cache key: 'resident'
  attributes :name,
             :balance,
             :meals_attended

  def balance
    ActionController::Base.helpers.number_to_currency(object.balance/100.to_f)
  end
end
