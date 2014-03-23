require 'spec_helper'

describe BatchPurchase do
    let(:valid_purchase_line) { "Snake Plissken\t$10 off $20 of food\t10.0\t2\t987 Fake St\tBob's Pizza" }
    let(:invalid_purchase_line) { "Just\ta list\tof tabs" }
    let(:batch_purchase) { BatchPurchase.new }

    describe "#parse_line" do
        it "returns nil when passed line with wrong number of tabs" do
            expect(batch_purchase.parse_line(invalid_purchase_line)).to be_nil
        end

        it "doesn't create a purchase item for an invalid line" do
            batch_purchase.parse_line(invalid_purchase_line)
            expect { batch_purchase.save }.to_not change(BatchPurchase, :count)
        end

        it "creates a purchase item for a valid line" do
            batch_purchase.parse_line(valid_purchase_line)
            expect { batch_purchase.save }.to change(BatchPurchase, :count).by(1)
        end
    end

    describe "#gross_revenue" do
        let(:product1) { Product.new(price: 5) }
        let(:product2) { Product.new(price: 10) }


        let(:purchase1) { Purchase.new(product: product1, quantity: 5) }
        let(:purchase2) { Purchase.new(product: product2, quantity: 1) }
        let(:purchase3) { Purchase.new(product: product1, quantity: 10) }

        it "totals gross revenue from purchases" do
            batch_purchase = BatchPurchase.new(purchases: [ purchase1, purchase2 ])
            expect(batch_purchase.gross_revenue).to eq(35)
            batch_purchase.purchases << purchase3
            expect(batch_purchase.gross_revenue).to eq(85)
        end
    end
end
