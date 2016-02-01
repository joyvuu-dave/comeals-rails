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

class Community < ApplicationRecord
  validates :name, presence: true
  has_many :meals, dependent: :destroy

  def cap
    read_attribute(:cap) || Float::INFINITY
  end
end
