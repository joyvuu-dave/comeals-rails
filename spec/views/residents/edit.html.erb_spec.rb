require 'rails_helper'

RSpec.describe "residents/edit", type: :view do
  before(:each) do
    @resident = assign(:resident, Resident.create!(
      :name => "MyString",
      :multiplier => 1,
      :unit => nil
    ))
  end

  it "renders the edit resident form" do
    render

    assert_select "form[action=?][method=?]", resident_path(@resident), "post" do

      assert_select "input#resident_name[name=?]", "resident[name]"

      assert_select "input#resident_multiplier[name=?]", "resident[multiplier]"

      assert_select "input#resident_unit_id[name=?]", "resident[unit_id]"
    end
  end
end
