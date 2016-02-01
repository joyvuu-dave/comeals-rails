require 'rails_helper'

RSpec.describe "residents/new", type: :view do
  before(:each) do
    assign(:resident, Resident.new(
      :name => "MyString",
      :multiplier => 1,
      :unit => nil
    ))
  end

  it "renders new resident form" do
    render

    assert_select "form[action=?][method=?]", residents_path, "post" do

      assert_select "input#resident_name[name=?]", "resident[name]"

      assert_select "input#resident_multiplier[name=?]", "resident[multiplier]"

      assert_select "input#resident_unit_id[name=?]", "resident[unit_id]"
    end
  end
end
