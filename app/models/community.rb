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

class Community < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validate :only_one, on: :create

  def cap
    read_attribute(:cap) || Float::INFINITY
  end

  private
    def only_one
      errors[:base] << 'Only one community permitted.' if Community.count > 0
    end
end
