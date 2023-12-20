# frozen_string_literal: true

require_relative '../../service/offer_service'
require_relative '../../model/product'
require_relative '../../model/cart_item'
require_relative '../../builder/product_builder'

RSpec.describe OfferService do
  let(:offer_service) { OfferService.new }

  let(:green_tea) { ProductBuilder.product(code: 'GR1') }
  let(:strawberries) { ProductBuilder.product(code: 'SR1') }
  let(:coffee) {ProductBuilder.product(code: 'CF1') }

  describe '#initialize' do
    it 'loads offers from the JSON file' do
      expect(offer_service.instance_variable_get(:@offers).size).to be > 0
    end
  end

  describe '#apply_offers' do
    context 'with BOGOF offer for green tea' do
      it 'applies BOGOF offer correctly' do
        cart_items = 2.times.map { CartItem.new(green_tea) }
        offer_service.apply_offers(cart_items)
        expect(cart_items.map(&:price)).to eq([3.11, 0])
      end
    end

    context 'with bulk discount offer for strawberries' do
      it 'applies bulk discount correctly when quantity is above threshold' do
        cart_items = 3.times.map { CartItem.new(strawberries) }
        offer_service.apply_offers(cart_items)
        expect(cart_items.map(&:price).uniq).to eq([4.50])
      end
    end

    context 'with discount offer for coffee' do
      it 'applies discount correctly when quantity is above threshold' do
        cart_items = 3.times.map { CartItem.new(coffee) }
        offer_service.apply_offers(cart_items)
        discounted_price = (11.23 * 2 / 3).round(2)
        expect(cart_items.map(&:price).uniq).to eq([discounted_price])
      end
    end
  end

  describe 'handling unknown offer types' do
    it 'raises an error for unknown offer types' do
      allow(File).to receive(:read).and_return('[{"code": "unknown_offer", "product_code": "GR1"}]')
      expect { OfferService.new }.to raise_error(RuntimeError, /Unknown offer type/)
    end
  end
end
