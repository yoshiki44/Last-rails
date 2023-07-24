require 'rails_helper'

RSpec.describe 'Products', type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:image) { create(:image) }
  let!(:related_products) {
    create_list(:product, 5, taxons: [taxon]).each_with_index do |product, i|
    product.price = i+1
    product.save!
  end
}
  let!(:other_product) { create(:product) }

  before do
    product.images << image
    related_products.each do |related_product|
      related_product.images << create(:image)
    end
    visit potepan_product_path(product.id)
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
    expect(current_path).to eq potepan_category_path(product.taxons.first.id)
  end

  it '商品名を表示すること' do
    expect(page).to have_content product.name
  end

  it '商品単価を表示すること' do
    expect(page).to have_content product.display_price.to_s
  end

  it '商品説明を表示すること' do
    expect(page).to have_content product.description
  end

  it '関連商品の品名、価格、表示されていること' do
    within '.productsContent' do
      related_products.first(4).all? do |related_product|
        binding.pry
        expect(page).to have_content related_product.name
        expect(page).to have_content related_product.display_price.to_s
      end
    end
  end

  it '関連商品から、商品詳細ページに遷移できること' do
    within '.productsContent' do
      related_products.first(4).all? do |related_product|
        click_on related_product.name
        expect(current_path).to eq potepan_product_path(related_product.id)
      end
    end
  end

  it '関連しない商品が表示されないこと' do
    expect(page).to_not have_content other_product.name
  end

  it '関連商品が４つ表示されていること' do
    expect(page.all('.productBox').count).to eq 4
  end
end
