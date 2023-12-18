require_relative '../model/product'
require 'json'

class ProductBuilder
  def self.product(code:)
    file = File.read('db/products.json')
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