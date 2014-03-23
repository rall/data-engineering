require 'spec_helper'

describe Product do

    describe "normalization on price" do
        specify { expect(Product.new(price: 9.99).price).to eq(9.99) }
        specify { expect(Product.new(price: "9.99").price).to eq(9.99) }
        specify { expect(Product.new(price: "$9.99").price).to eq(9.99) }
    end
end
