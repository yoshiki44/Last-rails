class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxons = Spree::Taxon.find(@product.taxons.ids)
    @related_products = @product.related_products
  end
end
