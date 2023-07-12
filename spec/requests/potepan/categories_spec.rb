require 'rails_helper'

RSpec.describe 'CategoriesRequests', type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy, name: 'Bags') }
  let(:product1) { create(:product, taxons: [taxon1]) }
  let(:product2) { create(:product) }
  let(:image1) { create(:image) }
  let(:image2) { create(:image) }

  describe 'GET /show' do
    before do
      product1.images << image1
      product2.images << image2
      get potepan_category_path(taxon1.id)
    end

    it 'カテゴリーページの表示に成功すること' do
      expect(response).to have_http_status 200
    end

    it 'カテゴリー名が取得できること' do
      expect(response.body).to include taxon1.name
    end

    it '商品名が取得できること' do
      expect(response.body).to include product1.name
    end

    it '商品単価が取得できること' do
      expect(response.body).to include product1.display_price.to_s
    end

    it 'カテゴリーが異なる商品が表示されないこと' do
      expect(response.body).to_not include product2.name
    end

    it 'taxonomy名が取得できること' do
      expect(response.body).to include taxonomy.name
    end
  end
end
