class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :merchant_id
      t.integer :customer_id
      t.integer :product_id

      t.timestamps
    end
  end
end
