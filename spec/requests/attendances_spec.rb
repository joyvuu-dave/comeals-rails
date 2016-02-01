# == Schema Information
# Schema version: 20160131201418
#
# Table name: attendances
#
#  id          :integer          not null, primary key
#  name        :string
#  multiplier  :integer          not null
#  is_guest    :boolean          default(FALSE), not null
#  resident_id :integer
#  meal_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_attendances_on_meal_id      (meal_id)
#  index_attendances_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_36737571be  (resident_id => residents.id)
#  fk_rails_79aff66e8d  (meal_id => meals.id)
#

require 'rails_helper'

RSpec.describe "Attendances", type: :request do
  describe "GET /attendances" do
    it "works! (now write some real specs)" do
      get attendances_path
      expect(response).to have_http_status(200)
    end
  end
end
