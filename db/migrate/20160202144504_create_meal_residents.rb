class CreateMealResidents < ActiveRecord::Migration[5.0]
  def change
    create_table :meal_residents do |t|
      t.references :meal, foreign_key: true
      t.references :resident, foreign_key: true
      t.integer :multiplier, null: false

      t.timestamps
    end

    add_index :meal_residents, [:meal_id, :resident_id]
  end
end
