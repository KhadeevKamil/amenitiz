# frozen_string_literal: true

require_relative '../../../model/concerns/offer_context'

RSpec.describe OfferContext do
  let(:offer) { double('offer') }
  subject(:offer_context) { OfferContext.new(offer) }

  describe '#initialize' do
    it 'initializes with an offer object' do
      expect(offer_context.instance_variable_get(:@offer)).to eq(offer)
    end
  end

  describe '#apply_offer' do
    let(:cart_items) { [double('cart_item'), double('cart_item')] }

    it 'calls apply_discount on the offer with the cart items' do
      expect(offer).to receive(:apply_discount).with(cart_items)
      offer_context.apply_offer(cart_items)
    end

    context 'when the cart is empty' do
      let(:empty_cart) { [] }

      it 'does not raise an error' do
        expect(offer).to receive(:apply_discount).with(empty_cart).at_most(:once)
        expect { offer_context.apply_offer(empty_cart) }.not_to raise_error
      end
    end
  end
end
