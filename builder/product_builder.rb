# frozen_string_literal: true

require_relative '../model/product'
require 'json'

PRODUCT_JSON = 'db/products.json'.freeze
class ProductBuilder
  def self.product(code:)
    file = File.read(PRODUCT_JSON)
    products_data = JSON.parse(file)

    # Find product data by code
    product_data = products_data.find { |p| p['code'] == code }

    if product_data
      Product.new(code: code, name: product_data['name'], price: product_data['price'])
    else
      nil # or raise an error if product not found
    end
  end
end