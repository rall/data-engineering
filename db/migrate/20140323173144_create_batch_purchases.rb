class CreateBatchPurchases < ActiveRecord::Migration
  def change
    create_table :batch_purchases do |t|

      t.timestamps
    end
  end
end
