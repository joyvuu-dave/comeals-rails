require 'rails_helper'

RSpec.describe "communities/index", type: :view do
  before(:each) do
    assign(:communities, [
      Community.create!(
        :name => "Name",
        :cap => 1
      ),
      Community.create!(
        :name => "Name",
        :cap => 1
      )
    ])
  end

  it "renders a list of communities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
