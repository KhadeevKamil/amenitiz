# frozen_string_literal: true

class OfferContext
  def initialize(offer)
    @offer = offer
  end

  def apply_offer(cart_items)
    @offer.apply_discount(cart_items)
  end
end
