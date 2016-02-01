class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.string :name
      t.integer :multiplier, null: false
      t.boolean :is_guest, null: false, default: false
      t.belongs_to :resident, foreign_key: true
      t.belongs_to :meal, foreign_key: true

      t.timestamps
    end
  end
end
