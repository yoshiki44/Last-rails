class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS_NUMBER = 4

  def show
    @product = Spree::Product.find(params[:id])
    @taxons = Spree::Taxon.find(@product.taxons.ids)
    @related_products = @product.related_products.includes(master: %i[images default_price]).limit(MAX_RELATED_PRODUCTS_NUMBER)
  end
end
