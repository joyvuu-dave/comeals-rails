class AddRotationLengthToCommunity < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :rotation_length, :integer
  end
end
