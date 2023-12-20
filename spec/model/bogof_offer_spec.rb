# frozen_string_literal: true

require_relative '../../model/bogof_offer'
require_relative '../../model/cart_item'
require_relative '../../model/product'
require_relative '../../builder/product_builder'

RSpec.describe BogofOffer do
  describe '#apply_discount' do
    let(:product) { ProductBuilder.product(code: 'GR1') }
    let(:other_product) { ProductBuilder.product(code: 'SR1') }

    it 'applies buy-one-get-one-free discount correctly' do
      cart_items = 2.times.map { CartItem.new(product) }
      cart_items += 2.times.map { CartItem.new(other_product) }

      BogofOffer.new.apply_discount(cart_items)

      expect(cart_items[0].price).to eq 3.11 # First item is paid
      expect(cart_items[1].price).to eq 0.00 # Second item is free
    end

    it 'handles odd number of items correctly' do
      cart_items = 3.times.map { CartItem.new(product) }
      cart_items += rand(2..10).times.map { CartItem.new(other_product) }

      BogofOffer.new.apply_discount(cart_items)

      expect(cart_items[0].price).to eq 3.11 # First item is paid
      expect(cart_items[1].price).to eq 3.11 # Second item is paid
      expect(cart_items[2].price).to eq 0.00 # Third item is free
    end

    it 'handle when just single item correctly' do
      cart_items = [CartItem.new(product)]
      cart_items += 2.times.map { CartItem.new(other_product) }

      BogofOffer.new.apply_discount(cart_items)

      expect(cart_items[0].price).to eq 3.11 # First item is paid
    end
  end
end
