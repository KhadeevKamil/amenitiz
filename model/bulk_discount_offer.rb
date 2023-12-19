# frozen_string_literal: true

require_relative 'offer'
require_relative 'cart_item'

OFFERS_JSON = 'db/offers.json'.freeze
BULK_OFFER_CODE = 'bulk_discount'.freeze

# Bulk Discount Offer
class BulkDiscountOffer < Offer
  def apply_discount(cart_items)
    if cart_items.size >= threshold_quantity
      cart_items.each { |cart_item| cart_item.price = discount_price }
    end
  end

  private

  def offer_data
    @offer_data ||= read_offer_data
  end

  def read_offer_data
    file = File.read(OFFERS_JSON)
    JSON.parse(file).find { |offer| offer['code'] == BULK_OFFER_CODE }
  end

  def discount_price
    offer_data['discount_price']
  end

  def threshold_quantity
    offer_data['threshold_quantity']
  end
end
