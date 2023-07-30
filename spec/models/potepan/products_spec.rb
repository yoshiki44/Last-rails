require 'rails_helper'

RSpec.describe 'Products', type: :model do
  describe '#related_products' do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let!(:taxon) { create(:taxon) }
    let!(:taxon2) { create(:taxon, name: 'taxon2') }
    let!(:taxon3) { create(:taxon, name: 'taxon3') }
    let!(:taxon4) { create(:taxon, name: 'taxon4') }
    let!(:taxon5) { create(:taxon, name: 'taxon5') }
    let!(:product) { create(:product, taxons: [taxon, taxon2, taxon3, taxon4]) }
    let!(:related_product1) { create(:product, taxons: [taxon]) }
    let!(:related_product2) { create(:product, taxons: [taxon2]) }
    let!(:related_product3) { create(:product, taxons: [taxon3]) }
    let!(:related_product4) { create(:product, taxons: [taxon4]) }
    let!(:other_product) { create(:product, taxons: [taxon5]) }

    it '表示される関連商品が重複していないこと' do
      expect(product.related_products).to eq [related_product1, related_product2, related_product3, related_product4]
    end

    it '関連しない商品は取得されないこと' do
      expect(product.related_products).to_not include other_product
    end
  end
end
