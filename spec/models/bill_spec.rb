# == Schema Information
# Schema version: 20170112210803
#
# Table name: bills
#
#  id              :integer          not null, primary key
#  meal_id         :integer
#  resident_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#
# Indexes
#
#  index_bills_on_meal_id      (meal_id)
#  index_bills_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (resident_id => residents.id)
#

require 'rails_helper'

RSpec.describe Bill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
