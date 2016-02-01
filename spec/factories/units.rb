# == Schema Information
# Schema version: 20160131201418
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :unit do
    name "MyString"
  end

end
