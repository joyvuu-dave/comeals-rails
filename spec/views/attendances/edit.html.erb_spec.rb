require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      :name => "MyString",
      :multiplier => 1,
      :is_guest => false,
      :resident => nil,
      :meal => nil
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do

      assert_select "input#attendance_name[name=?]", "attendance[name]"

      assert_select "input#attendance_multiplier[name=?]", "attendance[multiplier]"

      assert_select "input#attendance_is_guest[name=?]", "attendance[is_guest]"

      assert_select "input#attendance_resident_id[name=?]", "attendance[resident_id]"

      assert_select "input#attendance_meal_id[name=?]", "attendance[meal_id]"
    end
  end
end
