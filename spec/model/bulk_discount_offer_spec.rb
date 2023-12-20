# frozen_string_literal: true

require_relative '../../model/bulk_discount_offer'
require_relative '../../model/cart_item'
require_relative '../../model/product'
require_relative '../../builder/product_builder'

RSpec.describe BulkDiscountOffer do
  describe '#apply_discount' do
    let(:product) { ProductBuilder.product(code: 'SR1') }
    let(:other_product) { ProductBuilder.product(code: 'GR1') }

    context 'when quantity threshold is met' do
      it 'applies bulk discount correctly when quantity is 3' do
        cart_items = 3.times.map { CartItem.new(product) }
        cart_items += 2.times.map { CartItem.new(other_product) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == product.code }
        applicable_items.each do |cart_item|
          expect(cart_item.price).to eq 4.50
        end
      end

      it 'applies bulk discount correctly when quantity more that 3' do
        cart_items = rand(4..10).times.map { CartItem.new(product) }
        cart_items += rand(4..10).times.map { CartItem.new(other_product) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == product.code }
        applicable_items.each do |cart_item|
          expect(cart_item.price).to eq 4.50
        end
      end
    end

    context 'when quantity threshold is not met' do
      it 'does not apply discount' do
        cart_items = 2.times.map { CartItem.new(product) }
        cart_items += 2.times.map { CartItem.new(other_product) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == product.code }
        applicable_items.each do |cart_item|
          expect(cart_item.price).to eq 5.00
        end
      end
    end
  end
end