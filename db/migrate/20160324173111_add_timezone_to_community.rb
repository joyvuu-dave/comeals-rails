class AddTimezoneToCommunity < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :time_zone, :string, null: false, default: 'UTC'
    add_column :meals, :time_zone, :string
  end
end
