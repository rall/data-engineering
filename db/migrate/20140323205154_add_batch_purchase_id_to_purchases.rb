class AddBatchPurchaseIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :batch_purchase_id, :integer
  end
end
