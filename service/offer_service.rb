# frozen_string_literal: true

require 'json'
require_relative '../model/bogof_offer'
require_relative '../model/bulk_discount_offer'
require_relative '../model/discount_offer'
require_relative '../model/concerns/offer_context'

class OfferService
  def initialize
    @offers = load_offers
  end

  def apply_offers(cart_items)
    @offers.each do |offer|
      offer_context = OfferContext.new(offer)
      offer_context.apply_offer(cart_items)
    end
  end

  private

  def load_offers
    file = File.read(Offer::OFFERS_JSON)
    offers_data = JSON.parse(file)

    offers_data.map do |offer_data|
      case offer_data['code']
      when 'bogof_offer'
        BogofOffer.new
      when 'bulk_discount'
        BulkDiscountOffer.new
      when 'discount'
        DiscountOffer.new
      else
        raise "Unknown offer type: #{offer_data['code']}"
      end
    end
  end
end
