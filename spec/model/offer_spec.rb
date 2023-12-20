# frozen_string_literal: true

require_relative '../../model/offer'

RSpec.describe Offer do
  describe '#apply_discount' do
    it 'raises NotImplementedError' do
      expect { Offer.new.apply_discount([]) }.to raise_error(NotImplementedError)
    end
  end

  describe '#offer_data' do
    let(:offer_code) { 'bulk_discount' }
    let(:offer) { Offer.new }

    before do
      allow(offer).to receive(:offer_code).and_return(offer_code)
    end

    it 'loads and parses offer data from JSON file' do
      expect(offer.send(:offer_data)).to be_a(Hash)
      expect(offer.send(:offer_data)['product_code']).not_to be_nil
    end
  end
end
