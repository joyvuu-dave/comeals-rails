require 'rails_helper'

RSpec.describe "meals/edit", type: :view do
  before(:each) do
    @meal = assign(:meal, Meal.create!(
      :cap => 1
    ))
  end

  it "renders the edit meal form" do
    render

    assert_select "form[action=?][method=?]", meal_path(@meal), "post" do

      assert_select "input#meal_cap[name=?]", "meal[cap]"
    end
  end
end
