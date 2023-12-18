# frozen_string_literal: true

class Product
  attr_accessor :name, :price, :code

  def initialize(name:, price:, code:)
    @name = name
    @price = price
    @code = code
  end
end