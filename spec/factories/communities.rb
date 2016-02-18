# == Schema Information
# Schema version: 20160218020330
#
# Table name: communities
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cap             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rotation_length :integer
#
# Indexes
#
#  index_communities_on_name  (name) UNIQUE
#

FactoryGirl.define do
  factory :community do
    name "Swan's Way"
    cap 250
  end
end
