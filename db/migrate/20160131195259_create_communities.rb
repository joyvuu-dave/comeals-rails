class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.integer :cap

      t.timestamps
    end
  end
end
