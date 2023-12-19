# frozen_string_literal: true

class OfferService
  def initialize(json_file)
    @offers = load_offers_from_json(json_file)
  end

  def apply_offers(cart_items)
    cart_items.group_by(&:code).each do |code, items|
      offer = find_offer_for_product(code)
      offer&.apply_discount(items)
    end
  end

  private

  def load_offers_from_json(json_file)
    file = File.read(json_file)
    offers_data = JSON.parse(file)

    offers_data.map do |offer_data|
      offer_type, product_code = offer_data.to_a.first
      [product_code, create_offer_instance(offer_type)]
    end.to_h
  end

  def find_offer_for_product(product_code)
    @offers[product_code]
  end

  def create_offer_instance(offer_type)
    case offer_type
    when 'bogo_offer'
      BogofOffer.new
    when 'bulk_discount'
      BulkDiscountOffer.new
    when 'discount'
      DiscountOffer.new
    else
      nil
    end
  end
end
