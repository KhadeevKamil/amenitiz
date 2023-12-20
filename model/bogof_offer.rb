# frozen_string_literal: true
require_relative 'offer'
require_relative 'cart_item'

# Buy-One-Get-One-Free Offer
class BogofOffer < Offer
  def apply_discount(cart_items)
    items = cart_items.select { |item| item.product.code == product_code_for_offer }

    # For every two cart_items, one is free.
    # If there's an odd number of cart_items, the last one is paid.
    free_items = items.size / 2
    paid_items = items.size - free_items

    # Adjust price based on the number of paid items
    # Set the price of free items to 0
    items.each_with_index do |item, index|
      if index >= paid_items
        item.price = 0
      else
        item.price = item.product.price
      end
    end

    items
  end

  private

  def offer_code
    'bogof_offer'
  end
end