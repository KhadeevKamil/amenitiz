require_relative '../../builder/product_builder'
require_relative '../../model/product'
require 'json'

RSpec.describe ProductBuilder do
  describe '.product' do
    context 'when the product code exists' do
      it 'creates a product with correct attributes' do
        product = ProductBuilder.product(code: 'GR1')
        expect(product).to be_a(Product)
        expect(product.code).to eq('GR1')
        expect(product.name).to eq('Green Tea')
        expect(product.price).to eq(3.11)
      end
    end

    context 'when the product code does not exist' do
      it 'returns nil' do
        product = ProductBuilder.product(code: 'unknown')
        expect(product).to be_nil
      end
    end
  end
end
