require 'rails_helper'

RSpec.describe 'カテゴリーページ', type: :system do
  let!(:taxonomy) { create(:taxonomy, name: "Categories") }
  let!(:taxon1) { create(:taxon, taxonomy: taxonomy, name: "Bags") }
  let!(:taxon2) { create(:taxon, taxonomy: taxonomy, name: "Mugs") }
  let!(:product1) { create(:product, taxons: [taxon1], name: "RAILS TOTE") }
  let!(:product2) { create(:product, taxons: [taxon1], name: "RAILS BAGPACK") }
  let!(:product3) { create(:product, taxons: [taxon2], name: "RAILS CAP") }
  let!(:image) { create(:image) }

  before do
    product1.images << image
    visit potepan_category_path(taxon1.id)
  end

  it 'カテゴリーページのロゴからトップページへ遷移できること' do
    within('.navbar-brand') do
      click_on 'logo'
      expect(current_path).to eq potepan_index_path
    end
  end

  it 'サイドバーにカテゴリーが表示されること' do
    binding.pry
    # taxonomyが表示される
    expect(page).to have_content taxonomy.name
    # taxon1, taxon2 のカテゴリ名(と紐づく商品数)が表示される
    expect(page).to have_content "#{taxon1.name} (#{taxon1.all_products.count})"
    expect(page).to have_content "#{taxon2.name} (#{taxon2.all_products.count})"
  end

  it 'taxon1に関する商品が表示されること' do
    expect(page).to have_content product1.name
    expect(page).to have_content product2.name
  end

  it 'taxon1に関連しない商品は表示されないこと' do
    expect(page).not_to have_content product3.name
  end
end
