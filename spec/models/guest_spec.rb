# == Schema Information
# Schema version: 20170112210803
#
# Table name: guests
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  multiplier  :integer          default(2), not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  vegetarian  :boolean          default(FALSE), not null
#  late        :boolean          default(FALSE), not null
#
# Indexes
#
#  index_guests_on_meal_id      (meal_id)
#  index_guests_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (resident_id => residents.id)
#

require 'rails_helper'

RSpec.describe Guest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
