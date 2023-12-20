# frozen_string_literal: true
require_relative 'offer'
require_relative 'cart_item'

# Discount Offer
class DiscountOffer < Offer
  DISCOUNT_CODE = 'discount'.freeze

  def apply_discount(cart_items)
    items = cart_items.select { |item| item.product.code == product_code_for_discount }

    if items.size >= threshold_quantity
      items.each { |item| item.price = calculate_discounted_price(items.first.product.price) }
    end
  end

  private

  def product_code_for_discount
    offer_data(DISCOUNT_CODE)['product_code']
  end

  def discounted_price
    discount_price = offer_data(DISCOUNT_CODE)['discounted_price']
    discount_price.first.to_f / discount_price.last.to_f
  end

  def threshold_quantity
    offer_data(DISCOUNT_CODE)['threshold_quantity']
  end

  def calculate_discounted_price(original_price)
    (original_price * discounted_price).round(2)
  end
end
