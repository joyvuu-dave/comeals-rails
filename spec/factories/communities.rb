# == Schema Information
# Schema version: 20160131201418
#
# Table name: communities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  cap        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :community do
    name "MyString"
cap 1
  end

end
