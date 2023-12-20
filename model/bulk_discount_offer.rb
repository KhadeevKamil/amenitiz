# frozen_string_literal: true

require_relative 'offer'
require_relative 'cart_item'

# Bulk Discount Offer
class BulkDiscountOffer < Offer
  BULK_OFFER_CODE = 'bulk_discount'.freeze

  def apply_discount(cart_items)
    if cart_items.size >= threshold_quantity
      cart_items.each { |cart_item| cart_item.price = discount_price }
    end
  end

  private

  def discount_price
    offer_data(BULK_OFFER_CODE)['discount_price']
  end

  def threshold_quantity
    offer_data(BULK_OFFER_CODE)['threshold_quantity']
  end
end
