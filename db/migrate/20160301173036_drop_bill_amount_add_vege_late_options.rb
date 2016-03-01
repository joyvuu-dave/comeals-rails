class DropBillAmountAddVegeLateOptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :bills, :amount
    add_column :meal_residents, :vegetarian, :boolean, null: false, default: false
    add_column :meal_residents, :late, :boolean, null: false, default: false
    add_column :guests, :vegetarian, :boolean, null: false, default: false
    add_column :guests, :late, :boolean, null: false, default: false
  end
end
