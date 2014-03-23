class Product < ActiveRecord::Base
    has_many :purchases
    normalize_attribute  :price, :with => :currency
end
