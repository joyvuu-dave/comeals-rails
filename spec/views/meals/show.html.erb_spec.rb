require 'rails_helper'

RSpec.describe "meals/show", type: :view do
  before(:each) do
    @meal = assign(:meal, Meal.create!(
      :cap => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
