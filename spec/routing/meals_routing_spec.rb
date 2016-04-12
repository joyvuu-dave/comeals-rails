
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
#  closed                    :boolean          default(FALSE), not null
#  time_zone                 :string
#  auto_close                :boolean          default(FALSE), not null
#
# Indexes
#
#  index_meals_on_reconciliation_id  (reconciliation_id)
#
# Foreign Keys
#
#  fk_rails_4ac0d4ffd3  (reconciliation_id => reconciliations.id)
#

require "rails_helper"

RSpec.describe MealsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/meals").to route_to("meals#index")
    end

    it "routes to #new" do
      expect(:get => "/meals/new").to route_to("meals#new")
    end

    it "routes to #show" do
      expect(:get => "/meals/1").to route_to("meals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/meals/1/edit").to route_to("meals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/meals").to route_to("meals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/meals/1").to route_to("meals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/meals/1").to route_to("meals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/meals/1").to route_to("meals#destroy", :id => "1")
    end

  end
end
