# frozen_string_literal: true

require_relative '../model/product'
require 'json'

PRODUCT_JSON = 'db/products.json'
class ProductBuilder
  def self.product(code:)
    file = File.read(PRODUCT_JSON)
    products_data = JSON.parse(file)

    # Find product data by code
    product_data = products_data.find { |p| p['code'] == code }

    raise "Product not found for code: #{code}" unless product_data

    Product.new(code: code, name: product_data['name'], price: product_data['price'])
  end
end
