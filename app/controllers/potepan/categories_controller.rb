class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(taxons: :products)
    @taxon = Spree::Taxon.find(params[:id])
    @category_products = @taxon.all_products.includes(master: %i[images default_price])
  end
end
