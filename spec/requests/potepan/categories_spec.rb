require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:taxonomy) { create(:taxonomy, name: 'Categories') }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy, name: 'Bags') }
  let!(:taxon2) { create(:taxon, taxonomy: taxonomy, name: 'Mugs') }
  let(:product1) { create(:product, taxons: [taxon1], name: 'RAILS TOTE') }
  let(:product2) { create(:product, taxons: [taxon1], name: 'RAILS BAGPACK') }
  let(:product3) { create(:product, taxons: [taxon2], name: 'RAILS CAP') }
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
      expect(response.body).to include product2.name
    end

    it '商品単価が取得できること' do
      expect(response.body).to include product1.display_price.to_s
      expect(response.body).to include product2.display_price.to_s
    end

    it 'カテゴリーが異なる商品が表示されないこと' do
      expect(response.body).to_not include product3.name
    end
  end
end
