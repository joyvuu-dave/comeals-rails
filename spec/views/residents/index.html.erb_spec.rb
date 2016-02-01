require 'rails_helper'

RSpec.describe "residents/index", type: :view do
  before(:each) do
    assign(:residents, [
      Resident.create!(
        :name => "Name",
        :multiplier => 1,
        :unit => nil
      ),
      Resident.create!(
        :name => "Name",
        :multiplier => 1,
        :unit => nil
      )
    ])
  end

  it "renders a list of residents" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
