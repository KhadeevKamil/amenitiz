# frozen_string_literal: true

require_relative 'offer_service'
require_relative '../model/cart_item'
require_relative '../builder/product_builder'

class CheckoutService
  def initialize
    @cart_items = []
    @offer_service = OfferService.new
  end

  def scan(product_code)
    product = ProductBuilder.product(code: product_code)
    raise "Product not found for code: #{product_code}" unless product

    @cart_items << CartItem.new(product)
  end

  def total
    @offer_service.apply_offers(@cart_items)
    @cart_items.sum(&:price)
  end
end
