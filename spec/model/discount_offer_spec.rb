require_relative '../../model/discount_offer'
require_relative '../../model/cart_item'
require_relative '../../model/product'
require_relative '../../builder/product_builder'

RSpec.describe DiscountOffer do
  describe '#apply_discount' do
    let(:product) { ProductBuilder.product(code: 'CF1') }
    let(:other_product) { ProductBuilder.product(code: 'GR1') }

    context 'when the discount is applicable' do
      it 'applies the discount correctly' do
        cart_items = 3.times.map { CartItem.new(product) }
        cart_items += 3.times.map { CartItem.new(other_product) }

        DiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == product.code }
        applicable_items.each do |cart_item|
          expect(cart_item.price).to eq (11.23 * (2.0 / 3.0)).round(2)
        end
      end
    end

    context 'when the discount is not applicable' do
      it 'does not apply the discount' do
        cart_items = [CartItem.new(product), CartItem.new(other_product)]

        DiscountOffer.new.apply_discount(cart_items)

        applicable_items = cart_items.select { |item| item.product.code == product.code }

        expect(applicable_items.first.price).to eq 11.23
      end
    end
  end
end
