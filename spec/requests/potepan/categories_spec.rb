require 'rails_helper'

RSpec.describe 'CategoriesRequests', type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy, name: 'Bags') }
  let(:related_product) { create(:product, taxons: [taxon1]) }
  let(:unrelated_product) { create(:product) }
  let(:related_image) { create(:image) }
  let(:unrelated_image) { create(:image) }

  describe 'GET /show' do
    before do
      related_product.images << related_image
      unrelated_product.images << unrelated_image
      get potepan_category_path(taxon1.id)
    end

    it 'カテゴリーページの表示に成功すること' do
      expect(response).to have_http_status 200
    end

    it 'カテゴリー名が取得できること' do
      expect(response.body).to include taxon1.name
    end

    it '商品名が取得できること' do
      expect(response.body).to include related_product.name
    end

    it '商品単価が取得できること' do
      expect(response.body).to include related_product.display_price.to_s
    end

    it 'カテゴリーが異なる商品が表示されないこと' do
      expect(response.body).to_not include unrelated_product.name
    end

    it 'taxonomy名が取得できること' do
      expect(response.body).to include taxonomy.name
    end
  end
end
