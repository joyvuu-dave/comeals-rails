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

RSpec.describe "Communities", type: :request do
  describe "GET /communities" do
    it "works! (now write some real specs)" do
      get communities_path
      expect(response).to have_http_status(200)
    end
  end
end
