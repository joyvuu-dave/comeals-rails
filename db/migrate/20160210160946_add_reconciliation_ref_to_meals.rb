class AddReconciliationRefToMeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :meals, :reconciliation, foreign_key: true
  end
end
