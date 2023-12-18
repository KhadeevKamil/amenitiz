# frozen_string_literal: true

require_relative 'builder/product_builder'

product = ProductBuilder.product(code: "GR1")
puts product.name