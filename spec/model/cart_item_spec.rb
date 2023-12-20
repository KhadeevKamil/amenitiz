# frozen_string_literal: true

require_relative '../../model/cart_item'
require_relative '../../builder/product_builder'

RSpec.describe CartItem do
  let(:product) { ProductBuilder.product(code: 'SR1') }
  let(:cart_item) { CartItem.new(product) }

  describe '#initialize' do
    it 'initializes with the correct product' do
      expect(cart_item.product).to eq(product)
    end

    it 'sets the initial price from the product' do
      expect(cart_item.price).to eq(product.price)
    end
  end

  describe '#code' do
    it 'returns the product code' do
      expect(cart_item.code).to eq('SR1')
    end
  end
end
