class Purchase < ActiveRecord::Base
    belongs_to :merchant
    belongs_to :customer
    belongs_to :product
    belongs_to :batch_purchase

    def gross_revenue
        quantity * product.price
    end
end
