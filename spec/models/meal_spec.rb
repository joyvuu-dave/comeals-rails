# == Schema Information
# Schema version: 20170112210803
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  description               :text
#  max                       :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  reconciliation_id         :integer
#  bills_count               :integer          default(0), not null
#
# Indexes
#
#  index_meals_on_reconciliation_id  (reconciliation_id)
#
# Foreign Keys
#
#  fk_rails_...  (reconciliation_id => reconciliations.id)
#

require 'rails_helper'

RSpec.describe Meal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
