require 'spec_helper'

describe Purchase do
    let(:product) { Product.new(price: 10)}

    describe "#gross_revenue" do
        it "returns price when quantity is 1" do
            purchase = Purchase.new(quantity: 1, product: product)
            expect(purchase.gross_revenue).to eq(10)
        end

        it "multiplies price by quantity" do
            purchase_1 = Purchase.new(quantity: 5, product: product)
            expect(purchase_1.gross_revenue).to eq(50)
            purchase_2 = Purchase.new(quantity: 10, product: product)
            expect(purchase_2.gross_revenue).to eq(100)
        end

    end
end
