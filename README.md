# Checkout Application

## Overview

This Checkout Application is a Ruby-based command-line tool designed for simulating a shopping cart system. It incorporates an interactive interface for adding products, applies dynamic pricing rules based on the cart's contents, and calculates the total cost with discounts.

## Key Features

- **Interactive Product Addition**: Users can add products to their cart in real time using unique product codes.
- **Dynamic Pricing Rules**: Implements special pricing rules like buy-one-get-one-free (BOGOF) and bulk purchase discounts.
- **Real-time Total Calculation**: Calculates and displays the total cost of the cart, updating dynamically as products are added.
- **Flexible Product Management**: Products and pricing rules are defined in external JSON files, allowing for easy updates and maintenance.

## Setup and Installation

**Clone the Repository**:
`git clone git@github.com:KhadeevKamil/amenitiz.git`

## Usage

1. Run the application:
```bash
ruby main.rb
```
2. Enter product codes separated by commas (e.g., `GR1,SR1,GR1`) when prompted.
3. Type `DONE` to finish adding products and view the total price.

## Testing

Comprehensive RSpec tests are provided to ensure functionality:
```bash
rspec
```

## Components

- **ProductBuilder**: Constructs product instances from provided product codes, leveraging data from `products.json`.
- **Offer Classes**: Includes various classes like `BogofOffer` and `BulkDiscountOffer` that apply specific discount rules..
- **CheckoutService**: Central component managing the cart, scanning products, and applying offers to calculate the final total.

## Author

[Kamil Khadeev](https://www.linkedin.com/in/kamil-khadeev/)