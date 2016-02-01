# == Schema Information
# Schema version: 20160131201418
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

require "rails_helper"

RSpec.describe ResidentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/residents").to route_to("residents#index")
    end

    it "routes to #new" do
      expect(:get => "/residents/new").to route_to("residents#new")
    end

    it "routes to #show" do
      expect(:get => "/residents/1").to route_to("residents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/residents/1/edit").to route_to("residents#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/residents").to route_to("residents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/residents/1").to route_to("residents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/residents/1").to route_to("residents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/residents/1").to route_to("residents#destroy", :id => "1")
    end

  end
end
