# frozen_string_literal: true

Spree::Sample.load_sample("option_types")

size = Spree::OptionType.find_by!(presentation: "Size")
color = Spree::OptionType.find_by!(presentation: "Color")

Spree::OptionValue.create!([
  {
    name: "Small",
    presentation: "S",
    position: 1,
    option_type: size
  },
  {
    name: "Medium",
    presentation: "M",
    position: 2,
    option_type: size
  },
  {
    name: "Black",
    presentation: "Black",
    position: 1,
    option_type: color
  },
  {
    name: "White",
    presentation: "White",
    position: 2,
    option_type: color
  }
])
