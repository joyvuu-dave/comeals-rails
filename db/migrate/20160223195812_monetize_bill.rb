class MonetizeBill < ActiveRecord::Migration[5.0]
  def change
    add_monetize :bills, :amount
  end
end
