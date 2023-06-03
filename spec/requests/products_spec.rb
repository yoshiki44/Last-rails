require 'rails_helper'
require 'spree/testing_support/factories'

RSpec.describe 'Products', type: :request do
  let!(:product) { create(:product) }
  let!(:image) { create(:image) }
  # 画像URLの取得が上手くいかない問題への対応
  # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
  let!(:filename) do
    filename = image.attachment_blob.filename
    "#{filename.base}#{filename.extension_with_delimiter}"
  end

  describe 'GET /index' do
    it 'TOPページへのリンク' do
      get potepan_index_path
    end
  end

  describe 'GET /show' do
    before do
      product.images << image
      get potepan_path(product.id)
    end

    it '商品詳細ページの表示' do
      expect(response).to have_http_status 200
    end

    it '商品名の取得＆表示' do
      expect(response.body).to include product.name
    end

    it '商品単価の取得＆表示' do
      expect(response.body).to include product.display_price.to_s
    end

    it '商品説明の取得＆表示' do
      expect(response.body).to include product.description
    end

    it '商品画像の取得＆表示' do
      expect(response.body).to include filename
    end
  end
end
