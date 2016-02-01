class CreateResidents < ActiveRecord::Migration[5.0]
  def change
    create_table :residents do |t|
      t.string :name, null: false
      t.integer :multiplier, null: false, default: 2
      t.belongs_to :unit, foreign_key: true

      t.timestamps
    end
  end
end
