require_relative 'service/checkout_service'

puts "Welcome to the Checkout System"

loop do
  puts "Please enter product codes separated by commas (e.g., GR1,SR1,GR1), or type 'DONE' to finish:"
  input = gets.chomp
  break if input.upcase == 'DONE'

  # Create a new instance of CheckoutService for each input
  checkout_service = CheckoutService.new

  product_codes = input.split(',').map(&:strip)
  product_codes.each do |code|
    begin
      checkout_service.scan(code)
      puts "#{code} added to your cart."
    rescue RuntimeError => e
      puts "Error: #{e.message}"
    end
  end

  total = checkout_service.total
  puts "Total for entered products: #{'%.2f' % total}€"
end

puts "Checkout finished."
