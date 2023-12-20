# frozen_string_literal: true

class Offer
  OFFERS_JSON = 'db/offers.json'.freeze

  def apply_discount(products)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  private

  def offer_data(offer_code)
    @offer_data ||= read_offer_data(offer_code)
  end

  def read_offer_data(offer_code)
    file = File.read(OFFERS_JSON)
    JSON.parse(file).find { |offer| offer['code'] == offer_code }
  end
end