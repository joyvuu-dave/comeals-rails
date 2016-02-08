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

class UnitSerializer < ActiveModel::Serializer
  cache key: 'unit'
  attributes :name,
             :balance,
             :meals_cooked

  def balance
    ActionController::Base.helpers.number_to_currency(object.balance/100.to_f)
  end
end
