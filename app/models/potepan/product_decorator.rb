module Potepan::ProductDecorator
  def related_products
    Spree::Product.includes(master: %i[images default_price])
                  .in_taxons(taxons).where.not(id: id).distinct.limit(4)
  end
  Spree::Product.prepend self
end
