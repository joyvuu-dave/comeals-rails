require 'rails_helper'

RSpec.describe "bills/new", type: :view do
  before(:each) do
    assign(:bill, Bill.new(
      :meal => nil,
      :resident => nil,
      :amount => 1
    ))
  end

  it "renders new bill form" do
    render

    assert_select "form[action=?][method=?]", bills_path, "post" do

      assert_select "input#bill_meal_id[name=?]", "bill[meal_id]"

      assert_select "input#bill_resident_id[name=?]", "bill[resident_id]"

      assert_select "input#bill_amount[name=?]", "bill[amount]"
    end
  end
end
