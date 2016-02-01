class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.belongs_to :meal, foreign_key: true
      t.belongs_to :resident, foreign_key: true
      t.integer :amount, null: false, default: 0

      t.timestamps
    end
  end
end
