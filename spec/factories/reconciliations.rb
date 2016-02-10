# == Schema Information
# Schema version: 20160210160946
#
# Table name: reconciliations
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :reconciliation do
    date "2016-02-10"
  end
end
