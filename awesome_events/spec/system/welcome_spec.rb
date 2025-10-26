require 'rails_helper'

RSpec.describe "Welcome", type: :system do
  describe "/" do
    context "/ にアクセスするとき" do
      it "/ ページが表示されること" do
        visit root_path
        expect(page).to have_selector "h1", text: "イベント一覧"
      end
    end
  end
end