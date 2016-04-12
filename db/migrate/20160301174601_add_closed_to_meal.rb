class AddClosedToMeal < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :closed, :boolean, null: false, default: false
  end
end
