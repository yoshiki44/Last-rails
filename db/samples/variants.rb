# frozen_string_literal: true

Spree::Sample.load_sample("option_values")
Spree::Sample.load_sample("products")

solidus_tshirt = Spree::Product.find_by!(name: "Solidus T-Shirt")
solidus_snapback_cap = Spree::Product.find_by!(name: "Solidus Snapback Cap")
solidus_hoodie = Spree::Product.find_by!(name: "Solidus Hoodie Zip")
ruby_hoodie = Spree::Product.find_by!(name: "Ruby Hoodie")
ruby_hoodie_zip = Spree::Product.find_by!(name: "Ruby Hoodie Zip")
ruby_polo = Spree::Product.find_by!(name: "Ruby Polo")
ruby_mug = Spree::Product.find_by!(name: "Ruby Mug")
solidus_tote = Spree::Product.find_by!(name: "Solidus Tote")
solidus_girly = Spree::Product.find_by!(name: "Solidus Girly")

small = Spree::OptionValue.find_by!(name: "Small")
medium = Spree::OptionValue.find_by!(name: "Medium")

black = Spree::OptionValue.find_by!(name: "Black")
white = Spree::OptionValue.find_by!(name: "White")

variants = [
  {
    product: solidus_tshirt,
    option_values: [small, black],
    sku: "SOL-00002",
    cost_price: 17
  },
  {
    product: solidus_tshirt,
    option_values: [small, white],
    sku: "SOL-00004",
    cost_price: 17
  },
  {
    product: solidus_girly,
    option_values: [small, black],
    sku: "SOL-WM001",
    cost_price: 17
  },
  {
    product: solidus_girly,
    option_values: [small, white],
    sku: "SOL-WM003",
    cost_price: 17
  },
  {
    product: solidus_girly,
    option_values: [medium, white],
    sku: "SOL-WM005",
    cost_price: 17
  },
  {
    product: solidus_girly,
    option_values: [medium, black],
    sku: "SOL-WM006",
    cost_price: 17
  }
]

masters = {
  solidus_tote => {
    sku: "SOL-TOT01",
    cost_price: 17
  },
  solidus_snapback_cap => {
    sku: "SOL-SNC01",
    cost_price: 17
  },
  solidus_tshirt => {
    sku: "SOL-00001",
    cost_price: 17
  },
  solidus_hoodie => {
    sku: "SOL-HD00",
    cost_price: 27
  },
  ruby_hoodie => {
    sku: "RUB-HD01",
    cost_price: 27
  },
  ruby_hoodie_zip => {
    sku: "RUB-HD00",
    cost_price: 27
  },
  ruby_polo => {
    sku: "RUB-PL01",
    cost_price: 23
  },
  ruby_mug => {
    sku: "RUB-MG01",
    cost_price: 7
  },
  solidus_girly => {
    sku: "SOL-WM00",
    cost_price: 17
  }
}

Spree::Variant.create!(variants)

masters.each do |product, variant_attrs|
  product.master.update!(variant_attrs)
end
