require 'rails_helper'

RSpec.describe "bills/index", type: :view do
  before(:each) do
    assign(:bills, [
      Bill.create!(
        :meal => nil,
        :resident => nil,
        :amount => 1
      ),
      Bill.create!(
        :meal => nil,
        :resident => nil,
        :amount => 1
      )
    ])
  end

  it "renders a list of bills" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
