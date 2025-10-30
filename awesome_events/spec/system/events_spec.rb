require 'rails_helper'

RSpec.describe "Events", type: :system do

  describe "/events/:id" do
    context "/events/:id にアクセスするとき" do
      let(:event){ FactoryBot.create(:event) }
      
      it "/events/:id ページが表示されること" do
        visit event_path(event)
        expect(page).to have_selector "h1", text: event.name
      end 
    end
  end

  describe "GET /events/new" do
    context "/events/new にアクセスするとき" do
      it "/events/:new ページが表示されること" do
        sign_in_as(FactoryBot.create(:user))
        
        visit new_event_path
        expect(page).to have_selector "h1", text: "イベント作成"
      end
    end
  end

  describe "POST /events/create" do
    context "/events/new ページでフォームを記入して登録するとき" do
      it "イベントの作成が成功すること" do
        sign_in_as(FactoryBot.create(:user))
        
        visit new_event_path
        expect(page).to have_selector "h1", text: "イベント作成"

        fill_in "名前", with: "TokyuRubyKaigi" # ちなみに入力先の指定はモデル名_項目名（"event_name"）とかでもOK
        fill_in "場所", with: "東京"
        fill_in "内容", with: "tokyu.rb による地域Ruby会議"

        start_at = Time.current
        end_at = start_at + 3.hour

        start_at_field = "event_start_at"
        select start_at.strftime("%Y"), from: "#{start_at_field}_1i"
        select I18n.l(start_at, format: '%b'), from: "#{start_at_field}_2i"
        select start_at.strftime("%-d"), from: "#{start_at_field}_3i"
        select start_at.strftime("%H"), from: "#{start_at_field}_4i"
        select start_at.strftime("%M"), from: "#{start_at_field}_5i"

        end_at_field = "event_end_at"
        select end_at.strftime("%Y"), from: "#{end_at_field}_1i"
        select I18n.l(end_at, format: '%b'), from: "#{end_at_field}_2i"
        select end_at.strftime("%-d"), from: "#{end_at_field}_3i"
        select end_at.strftime("%H"), from: "#{end_at_field}_4i"
        select end_at.strftime("%M"), from: "#{end_at_field}_5i"

        click_on "登録する"
        expect(page).to have_selector "div.alert", text: "作成しました"
      end
    end

    describe "DELETE /events/:id" do
      context "/events/:id ページを表示して削除ボタンを押下した時" do
        it "イベントを削除できること" do
          sign_in_as(FactoryBot.create(:user))
          event = FactoryBot.create(:event, owner: current_user)

          visit event_path(event)
          expect do
            page.accept_confirm do
              click_on "イベントを削除する"
            end
            expect(page).to have_selector "div.alert", text: "削除しました"
          end.to change(Event, :count).by(-1)
          expect(page).not_to have_content event.name
        end
      end
    end
  end
end
