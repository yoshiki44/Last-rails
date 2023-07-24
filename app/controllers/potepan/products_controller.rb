class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxons = Spree::Taxon.find(@product.taxons.ids)
    @related_products = @product.related_products.includes(master: %i[images default_price]).limit(4)
  end
end
