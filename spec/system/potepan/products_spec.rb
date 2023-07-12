require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product) { create(:product, taxons: [taxon1]) }
  let(:unrelated_product) { create(:product) }
  let(:related_image) { create(:image) }
  let(:unrelated_image) { create(:image) }

  before do
    related_product.images << related_image
    unrelated_product.images << unrelated_image
    visit potepan_product_path(related_product.id)
  end

  it '詳細ページのロゴからトップページへ遷移できること' do
    within('.navbar-brand') do
      click_on 'logo'
      expect(current_path).to eq potepan_index_path
    end
  end

  it '詳細ページのヘッダーのHomeからトップページへ遷移できること' do
    within('.nav') do
      click_on 'Home'
      expect(current_path).to eq potepan_index_path
    end
  end

  it '詳細ページのページヘッダーのHomeからトップページへ遷移できること' do
    within('.breadcrumb') do
      click_on 'Home'
      expect(current_path).to eq potepan_index_path
    end
  end

  it '一覧ページへ戻れること' do
    click_on '一覧ページへ戻る'
    expect(current_path).to eq potepan_category_path(related_product.taxons.first.id)
  end

  it '商品名を表示すること' do
    expect(page).to have_content related_product.name
  end

  it '商品単価を表示すること' do
    expect(page).to have_content related_product.display_price.to_s
  end

  it '商品説明を表示すること' do
    expect(page).to have_content related_product.description
  end
end
