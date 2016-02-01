class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.date :date, null: false
      t.belongs_to :community, foreign_key: true
      t.integer :cap
      t.integer :attendances_count

      t.timestamps
    end
  end
end
