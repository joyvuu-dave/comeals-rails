class AddBillsCountToMeals < ActiveRecord::Migration[5.0]
  def up
    add_column :meals, :bills_count, :integer, null: false, default: 0
  end

  def down
    remove_column :meals, :bills_count
  end
end
