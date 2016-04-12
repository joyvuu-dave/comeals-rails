class AddVegetarianToResidents < ActiveRecord::Migration[5.0]
  def change
    add_column :residents, :vegetarian, :boolean, null: false, default: false
  end
end
