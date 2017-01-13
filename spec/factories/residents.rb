# == Schema Information
# Schema version: 20170112210803
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
#
# Indexes
#
#  index_residents_on_name     (name) UNIQUE
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (unit_id => units.id)
#

FactoryGirl.define do
  factory :resident do
    name "MyString"
    multiplier 2
    unit
  end
end
