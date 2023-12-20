# frozen_string_literal: true

class Offer
  OFFERS_JSON = 'db/offers.json'

  def apply_discount(products)
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  private

  def offer_code
    raise NotImplementedError, 'Subclasses must implement this method'
  end

  def offer_data
    @offer_data ||= read_offer_data(offer_code)
  end

  def read_offer_data(offer_code)
    file = File.read(OFFERS_JSON)
    JSON.parse(file).find { |offer| offer['code'] == offer_code }
  end

  def product_code_for_offer
    offer_data['product_code']
  end
end
