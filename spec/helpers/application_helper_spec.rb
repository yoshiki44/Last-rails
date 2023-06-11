require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title(page_title)" do
    subject { full_title(page_title) }

    context "page_titleが空白の場合" do
      let(:page_title) { "" }

      it { is_expected.to eq("BIGBAG Store") }
    end

    context "page_titleがnilの場合" do
      let(:page_title) { nil }

      it { is_expected.to eq("BIGBAG Store") }
    end

    context "page_titleが存在する場合" do
      let(:page_title) { "sample" }

      it { is_expected.to eq("sample - BIGBAG Store") }
    end
  end
end
