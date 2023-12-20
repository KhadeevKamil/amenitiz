# frozen_string_literal: true

require_relative 'service/checkout_service'

checkout_service = CheckoutService.new
puts "Welcome to the Checkout System"
puts "Please enter product codes separated by commas (e.g., GR1,SR1,GR1) or type 'DONE' to finish:"

loop do
  input = gets.chomp
  break if input.upcase == 'DONE'

  product_codes = input.split(',').map(&:strip)
  product_codes.each do |code|
    checkout_service.scan(code)
    puts "#{code} added to your cart."
  end

  puts "Current Total: #{'%.2f' % checkout_service.total}€"
  puts "Enter more product codes or 'DONE' to finish:"
end

total = checkout_service.total
puts "Final Total: #{'%.2f' % total}€"