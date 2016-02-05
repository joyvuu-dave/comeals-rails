# == Schema Information
# Schema version: 20160202150722
#
# Table name: communities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  cap        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_communities_on_name  (name) UNIQUE
#

class Community < ApplicationRecord
  validates :name, uniqueness: true

  def cap
    read_attribute(:cap) || Float::INFINITY
  end
end
