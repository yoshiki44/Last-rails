require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy) }
  let(:product1) { create(:product, taxons: [taxon1]) }
  let(:product2) { create(:product) }
  let(:image1) { create(:image) }
  let(:image2) { create(:image) }

  before do
    product1.images << image1
    product2.images << image2
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
    expect(page).to have_content product1.name
  end

  it 'taxon1に関連しない商品は表示されないこと' do
    expect(page).not_to have_content product2.name
  end

  it '商品名をクリックすると詳細ページに遷移できること' do
    click_link product1.name
    expect(current_path).to eq potepan_product_path(product1.id)
  end

  it 'サイドバーの商品数と表示されている商品数が一致していること' do
    expect(page.all('.productBox').count).to eq taxon1.all_products.size
  end
end
