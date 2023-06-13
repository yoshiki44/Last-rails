require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "詳細ページ", type: :system do
  let(:product) { create(:product) }
  let(:image) { create(:image) }

  before do
    visit potepan_product_path(product.id)
  end

  it "詳細ページのロゴからトップページへ遷移できること" do
    within(".navbar-brand") do
      click_on "logo"
      expect(current_path).to eq potepan_index_path
    end
  end

  it "詳細ページのヘッダーのHomeからトップページへ遷移できること" do
    within(".nav") do
      click_on "Home"
      expect(current_path).to eq potepan_index_path
    end
  end

  it "詳細ページのページヘッダーのHomeからトップページへ遷移できること" do
    within(".breadcrumb") do
      click_on "Home"
      expect(current_path).to eq potepan_index_path
    end
  end

  it '商品名の取得に成功すること' do
    expect(page).to have_content product.name
  end

  it '商品単価の取得に成功すること' do
    expect(page).to have_content product.display_price.to_s
  end

  it '商品説明の取得に成功すること' do
    expect(page).to have_content product.description
  end
end
