# == Schema Information
# Schema version: 20160131201418
#
# Table name: meals
#
#  id                :integer          not null, primary key
#  date              :date             not null
#  community_id      :integer
#  cap               :integer
#  attendances_count :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_meals_on_community_id  (community_id)
#
# Foreign Keys
#
#  fk_rails_0336f048cd  (community_id => communities.id)
#

FactoryGirl.define do
  factory :meal do
    date "2016-01-31"
cap 1
  end

end
