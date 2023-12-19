# frozen_string_literal: true

class CartItem
  attr_reader :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def code
    product.code
  end
end