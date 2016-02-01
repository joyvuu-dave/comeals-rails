require 'rails_helper'

RSpec.describe "bills/show", type: :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!(
      :meal => nil,
      :resident => nil,
      :amount => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
