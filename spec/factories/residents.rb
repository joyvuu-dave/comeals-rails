# == Schema Information
# Schema version: 20160131201418
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

FactoryGirl.define do
  factory :resident do
    name "MyString"
multiplier 1
unit nil
  end

end
