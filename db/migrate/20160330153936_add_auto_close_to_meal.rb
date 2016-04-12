class AddAutoCloseToMeal < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :auto_close, :boolean, null: false, default: false
  end
end
