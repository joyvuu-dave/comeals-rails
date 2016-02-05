# == Schema Information
# Schema version: 20160202150722
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_units_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe UnitsController, type: :controller do
  pending "add some examples to (or delete) #{__FILE__}"
end
