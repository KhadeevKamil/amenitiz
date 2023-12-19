# frozen_string_literal: true
require_relative 'offer'
require_relative 'cart_item'

# Buy-One-Get-One-Free Offer
class BogofOffer < Offer
  def apply_discount(cart_items)
    # For every two cart_items, one is free.
    # If there's an odd number of cart_items, the last one is paid.
    free_items = cart_items.size / 2
    paid_items = cart_items.size - free_items

    # Adjust price based on the number of paid items
    # Set the price of free items to 0
    cart_items.each_with_index do |cart_item, index|
      if index >= paid_items
        cart_item.price = 0
      else
        cart_item.price = cart_item.product.price
      end
    end

    cart_items
  end
end