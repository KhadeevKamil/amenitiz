# frozen_string_literal: true

require_relative 'offer'
require_relative 'cart_item'

# Bulk Discount Offer
class BulkDiscountOffer < Offer
  def apply_discount(cart_items)
    items = cart_items.select { |cart_item| cart_item.product.code == product_code_for_offer }

    return unless items.size >= threshold_quantity

    items.each { |item| item.price = discount_price }
  end

  private

  def offer_code
    'bulk_discount'
  end

  def discount_price
    offer_data['discount_price']
  end

  def threshold_quantity
    offer_data['threshold_quantity']
  end
end
