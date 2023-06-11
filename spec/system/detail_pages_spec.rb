require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe "詳細ページ", type: :system do
  let!(:product) { create(:product) }
  let!(:image) { create(:image) }

  it"詳細ページのロゴからトップページへ遷移できること" do
      visit potepan_product_path(product.id)
      find(".navbar-link").click
      expect(current_path).to eq(potepan_index_path)
  end

  it"詳細ページのヘッダーのHOMEからトップページへ遷移できること" do
      visit potepan_product_path(product.id)
      find(".header-home").click
      expect(current_path).to eq(potepan_index_path)
  end

  it"詳細ページのページヘッダーのHOMEからトップページへ遷移できること" do
      visit potepan_product_path(product.id)
      find(".pageheader-home").click
      expect(current_path).to eq(potepan_index_path)
  end


end
