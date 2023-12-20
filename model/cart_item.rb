# frozen_string_literal: true

class CartItem
  attr_reader :product, :quantity
  attr_accessor :price

  def initialize(product)
    @product = product
    @price = product.price
  end

  def code
    product.code
  end
end
