class AddPasswordToResidents < ActiveRecord::Migration[5.0]
  def change
    add_column :residents, :password_digest, :string
    add_index :residents, :password_digest, unique: true
  end
end
