# frozen_string_literal: true
require_relative 'offer'
require_relative 'cart_item'

# Discount Offer
class DiscountOffer < Offer
  def apply_discount(cart_items)
    items = cart_items.select { |item| item.product.code == product_code_for_offer }

    if items.size >= threshold_quantity
      items.each { |item| item.price = calculate_discounted_price(items.first.product.price) }
    end
  end

  private

  def offer_code
    'discount'
  end

  def discounted_price
    discount_price = offer_data['discounted_price']
    discount_price.first.to_f / discount_price.last.to_f
  end

  def threshold_quantity
    offer_data['threshold_quantity']
  end

  def calculate_discounted_price(original_price)
    (original_price * discounted_price).round(2)
  end
end
