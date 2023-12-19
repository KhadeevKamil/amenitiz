# frozen_string_literal: true

class Offer
  def apply_discount(products)
    raise NotImplementedError, 'Subclasses must implement this method'
  end
end