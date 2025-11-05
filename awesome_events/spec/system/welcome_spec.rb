require 'rails_helper'

RSpec.describe "Welcome", type: :system do
  describe "/" do
    context "/ にアクセスするとき" do
      it "/ ページが表示されること" do
        visit root_path
        expect(page).to have_selector "h1", text: "イベント一覧"
      end

      it "未来のイベントは表示され、過去のイベントは非表示であること" do
        future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.day)
        past_event = FactoryBot.create(:event, start_at: Time.zone.now + 1.day)

        travel_to(Time.zone.now + 2.day) do
          visit root_path
          expect(page).to have_selector "h5", text: future_event.name
          expect(page).not_to have_selector "h5", text: past_event.name
        end
      end
    end
  end
end