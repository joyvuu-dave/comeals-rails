# == Schema Information
# Schema version: 20160202150722
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  bill_costs :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_name     (name) UNIQUE
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

require 'rails_helper'

RSpec.describe "Residents", type: :request do
  describe "GET /residents" do
    it "works! (now write some real specs)" do
      get residents_path
      expect(response).to have_http_status(200)
    end
  end
end
