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

require 'rails_helper'

RSpec.describe Community, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
