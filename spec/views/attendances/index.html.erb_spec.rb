require 'rails_helper'

RSpec.describe "attendances/index", type: :view do
  before(:each) do
    assign(:attendances, [
      Attendance.create!(
        :name => "Name",
        :multiplier => 1,
        :is_guest => false,
        :resident => nil,
        :meal => nil
      ),
      Attendance.create!(
        :name => "Name",
        :multiplier => 1,
        :is_guest => false,
        :resident => nil,
        :meal => nil
      )
    ])
  end

  it "renders a list of attendances" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
