class CreateResidents < ActiveRecord::Migration[5.0]
  def change
    create_table :residents do |t|
      t.string :name, null: false
      t.integer :multiplier, null: false, default: 2
      t.belongs_to :unit, foreign_key: true
      t.integer :bill_costs, null: false, default: 0

      t.timestamps
    end

    add_index :residents, :name, unique: true
  end
end
