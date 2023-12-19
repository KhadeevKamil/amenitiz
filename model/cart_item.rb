# frozen_string_literal: true

class CartItem
  attr_reader :product, :quantity
  attr_accessor :price

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
    @price = product.price
  end

  def code
    product.code
  end
end