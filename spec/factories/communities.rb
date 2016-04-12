# == Schema Information
# Schema version: 20160324173111
#
# Table name: communities
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cap             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rotation_length :integer
#  time_zone       :string           default("UTC"), not null
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
