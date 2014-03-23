class BatchPurchase < ActiveRecord::Base
    has_many :purchases
    COLUMNS = [:purchaser_name, :item_description, :item_price, :count, :merchant_address, :merchant_name]

    validate :has_purchases

    def parse_line(tab_delimited_line)
        parsed_line = tab_delimited_line.split("\t")
        if parsed_line.length == COLUMNS.length
            parsed_attributes = parsed_line.inject({}) do |memo, value|
                index = parsed_line.index(value)
                attribute = COLUMNS[index]
                memo[attribute] = value
                memo
            end
            merchant = Merchant.where(
                name: parsed_attributes[:merchant_name],
                address: parsed_attributes[:merchant_address]).first_or_initialize
            customer = Customer.where(name: parsed_attributes[:purchaser_name]).first_or_initialize
            product = Product.where(
                description: parsed_attributes[:item_description],
                price: parsed_attributes[:item_price]
            ).first_or_initialize
            self.purchases.build(
                customer: customer,
                merchant: merchant,
                product: product,
                quantity: parsed_attributes[:count])
        end
    end

    def gross_revenue
        purchases.all.inject(0) { |sum, purchase| sum + purchase.gross_revenue }
    end

    private
    
    def has_purchases
        errors.add(:base, 'must have at least one purchase') if self.purchases.empty?
    end
end
