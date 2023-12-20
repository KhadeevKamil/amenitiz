require_relative '../../model/discount_offer'
require_relative '../../model/cart_item'
require_relative '../../model/product'
require_relative '../../builder/product_builder'

RSpec.describe DiscountOffer do
  describe '#apply_discount' do
    context 'when the discount is applicable' do
      it 'applies the discount correctly' do
        product = ProductBuilder.product(code: 'CF1')
        cart_items = 3.times.map { CartItem.new(product, 1) }

        strawberry_product = ProductBuilder.product(code: 'SR1')
        cart_items += 3.times.map { CartItem.new(strawberry_product, 1) }

        tea_product = ProductBuilder.product(code: 'GR1')
        cart_items += 3.times.map { CartItem.new(tea_product, 1) }

        DiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == 'CF1' }
        applicable_items.each do |cart_item|
          expect(cart_item.price).to eq (11.23 * (2.0 / 3.0)).round(2)
        end
      end
    end

    context 'when the discount is not applicable' do
      it 'does not apply the discount' do
        product = ProductBuilder.product(code: 'CF1')
        other_product = ProductBuilder.product(code: 'SR1')

        cart_items = [CartItem.new(product, 1), CartItem.new(other_product, 1)]

        DiscountOffer.new.apply_discount(cart_items)

        expect(cart_items.first.price).to eq 11.23
      end
    end
  end
end
