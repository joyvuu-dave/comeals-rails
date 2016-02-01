require 'rails_helper'

RSpec.describe "residents/show", type: :view do
  before(:each) do
    @resident = assign(:resident, Resident.create!(
      :name => "Name",
      :multiplier => 1,
      :unit => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
