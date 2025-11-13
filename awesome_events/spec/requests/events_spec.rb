require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "#destroy" do
    let!(:event_owner) { create :user }
    let!(:event) {create :event, owner: event_owner}
    
    it "自分の作ったイベントは削除できる" do
      sign_in_as event_owner
      expect do
        delete event_url(event)
      end.to change(Event, :count).by(-1)
    end

    it "他人の作ったイベントは削除できる" do
      sign_in_user = FactoryBot.create(:user)
      sign_in_as sign_in_user
      expect do
        delete event_url(event)
      end.to change(Event, :count).by(0)
    end
  end
end
