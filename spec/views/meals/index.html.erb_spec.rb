require 'rails_helper'

RSpec.describe "meals/index", type: :view do
  before(:each) do
    assign(:meals, [
      Meal.create!(
        :cap => 1
      ),
      Meal.create!(
        :cap => 1
      )
    ])
  end

  it "renders a list of meals" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
