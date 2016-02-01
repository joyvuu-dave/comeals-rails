require 'rails_helper'

RSpec.describe "bills/edit", type: :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!(
      :meal => nil,
      :resident => nil,
      :amount => 1
    ))
  end

  it "renders the edit bill form" do
    render

    assert_select "form[action=?][method=?]", bill_path(@bill), "post" do

      assert_select "input#bill_meal_id[name=?]", "bill[meal_id]"

      assert_select "input#bill_resident_id[name=?]", "bill[resident_id]"

      assert_select "input#bill_amount[name=?]", "bill[amount]"
    end
  end
end
