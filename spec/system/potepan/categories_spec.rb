require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product) { create(:product, taxons: [taxon1]) }
  let(:unrelated_product) { create(:product) }
  let(:related_image) { create(:image) }
  let(:unrelated_image) { create(:image) }

  before do
    related_product.images << related_image
    unrelated_product.images << unrelated_image
    visit potepan_category_path(taxon1.id)
  end

  it 'カテゴリーページのロゴからトップページへ遷移できること' do
    within('.navbar-brand') do
      click_on 'logo'
      expect(current_path).to eq potepan_index_path
    end
  end

  it 'サイドバーにカテゴリーが表示されること' do
    expect(page).to have_content taxonomy.name
    expect(page).to have_content "#{taxon1.name} (#{taxon1.all_products.size})"
  end

  it 'taxon1に関する商品が表示されること' do
    expect(page).to have_content related_product.name
  end

  it 'taxon1に関連しない商品は表示されないこと' do
    expect(page).not_to have_content unrelated_product.name
  end

  it '商品名をクリックすると詳細ページに遷移できること' do
    click_link related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
  end

  it 'サイドバーの商品数と表示されている商品数が一致していること' do
    expect(page.all('.productBox').count).to eq taxon1.all_products.size
  end
end
