require_relative '../../service/checkout_service'
require_relative '../../service/offer_service'
require_relative '../../model/cart_item'
require_relative '../../builder/product_builder'

RSpec.describe CheckoutService do
  let(:checkout_service) { CheckoutService.new }

  describe '#initialize' do
    it 'initializes with an empty cart and an instance of OfferService' do
      expect(checkout_service.instance_variable_get(:@cart_items)).to eq([])
      expect(checkout_service.instance_variable_get(:@offer_service)).to be_an_instance_of(OfferService)
    end
  end

  describe '#scan' do
    context 'when a valid product code is provided' do
      it 'adds the product to the cart' do
        expect { checkout_service.scan('GR1') }.to change { checkout_service.instance_variable_get(:@cart_items).length }.by(1)
      end
    end

    context 'when multiple valid products are scanned' do
      it 'adds all products to the cart' do
        expect do
          checkout_service.scan('GR1')
          checkout_service.scan('SR1')
          checkout_service.scan('CF1')
        end.to change { checkout_service.instance_variable_get(:@cart_items).length }.by(3)
      end
    end

    context 'when an invalid product code is provided' do
      it 'raises an error' do
        invalid_code = 'invalid_code'
        expect { checkout_service.scan(invalid_code) }.to raise_error("Product not found for code: #{invalid_code}")
      end
    end
  end

  describe '#total' do
    context 'examples from documentation' do
      context 'when purchasing two green teas' do
        it 'applies BOGOF offer and charges for only one' do
          2.times { checkout_service.scan('GR1') }
          expect(checkout_service.total).to eq(3.11) # Price of one green tea
        end
      end

      context 'when purchasing three strawberries and one green tea' do
        it 'applies bulk discount for strawberries and normal price for green tea' do
          3.times { checkout_service.scan('SR1') }
          checkout_service.scan('GR1')
          expect(checkout_service.total).to eq(4.5 * 3 + 3.11) # Bulk price for strawberries and normal price for green tea
        end
      end

      context 'when purchasing one of each product' do
        it 'charges normal price for each item without any discounts' do
          checkout_service.scan('GR1')
          checkout_service.scan('SR1')
          checkout_service.scan('CF1')
          expect(checkout_service.total).to eq(3.11 + 5.00 + 11.23)
        end
      end

      context 'when purchasing three coffees and one green tea' do
        it 'applies discount to coffees and normal price for green tea' do
          3.times { checkout_service.scan('CF1') }
          checkout_service.scan('GR1')
          discounted_coffee_price = (11.23 * 2 / 3)
          expect(checkout_service.total).to eq(discounted_coffee_price * 3 + 3.11)
        end
      end
    end

    context 'with mixed products in cart' do
      it 'returns the correct total with various offers applied' do
        2.times { checkout_service.scan('GR1') } # One should be free (BOGOF)
        3.times { checkout_service.scan('SR1') } # Bulk discount applies
        1.times { checkout_service.scan('CF1') }
        expected_total = 3 * 4.5 + ProductBuilder.product(code: 'CF1').price + ProductBuilder.product(code: 'GR1').price
        expect(checkout_service.total).to eq(expected_total)
      end
    end

    context 'when scanning items in a different order' do
      it 'still applies offers correctly' do
        checkout_service.scan('CF1')
        checkout_service.scan('GR1')
        checkout_service.scan('SR1')
        checkout_service.scan('GR1') # This should be free due to BOGOF
        expected_total = ProductBuilder.product(code: 'CF1').price + ProductBuilder.product(code: 'SR1').price + ProductBuilder.product(code: 'GR1').price
        expect(checkout_service.total).to eq(expected_total)
      end
    end

    context 'when purchasing only three coffees' do
      it 'applies a discount to all coffees' do
        3.times { checkout_service.scan('CF1') }
        discounted_coffee_price = (11.23 * 2 / 3)
        expect(checkout_service.total).to eq(discounted_coffee_price * 3)
      end
    end

    context 'when the cart is empty' do
      it 'returns zero' do
        expect(checkout_service.total).to eq(0)
      end
    end
  end
end
