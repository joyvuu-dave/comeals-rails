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

RSpec.describe "Units", type: :request do
  describe "GET /units" do
    it "works! (now write some real specs)" do
      get units_path
      expect(response).to have_http_status(200)
    end
  end
end
