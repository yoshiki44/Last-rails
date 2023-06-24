class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(taxons: :products)
    @taxon = Spree::Taxon.find(params[:id])
    @category_products = Spree::Product.in_taxons(@taxon).includes(:master, :variants)
  end
end
