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

require 'rails_helper'

RSpec.describe Reconciliation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
