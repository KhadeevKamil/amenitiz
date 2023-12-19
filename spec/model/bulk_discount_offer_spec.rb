require_relative '../../model/bulk_discount_offer'
require_relative '../../model/cart_item'
require_relative '../../model/product'
require_relative '../../builder/product_builder'

RSpec.describe BulkDiscountOffer do
  describe '#apply_discount' do
    context 'when quantity threshold is met' do
      it 'applies bulk discount correctly when quantity is 3' do
        product = ProductBuilder.product(code: 'SR1')
        cart_items = 3.times.map { CartItem.new(product, 1) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        cart_items.each do |cart_item|
          expect(cart_item.price).to eq 4.50
        end
      end

      it 'applies bulk discount correctly when quantity more that 3' do
        product = ProductBuilder.product(code: 'SR1')
        cart_items = rand(4..10).times.map { CartItem.new(product, 1) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        cart_items.each do |cart_item|
          expect(cart_item.price).to eq 4.50
        end
      end
    end

    context 'when quantity threshold is not met' do
      it 'does not apply discount' do
        product = ProductBuilder.product(code: 'SR1')
        cart_items = 2.times.map { CartItem.new(product, 1) }

        BulkDiscountOffer.new.apply_discount(cart_items)

        cart_items.each do |cart_item|
          expect(cart_item.price).to eq 5.00
        end
      end
    end
  end
end