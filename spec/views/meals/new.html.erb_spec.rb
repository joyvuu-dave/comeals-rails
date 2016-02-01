require 'rails_helper'

RSpec.describe "meals/new", type: :view do
  before(:each) do
    assign(:meal, Meal.new(
      :cap => 1
    ))
  end

  it "renders new meal form" do
    render

    assert_select "form[action=?][method=?]", meals_path, "post" do

      assert_select "input#meal_cap[name=?]", "meal[cap]"
    end
  end
end
