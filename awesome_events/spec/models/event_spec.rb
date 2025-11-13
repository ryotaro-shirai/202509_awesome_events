require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#created_by?" do
    let!(:event) { create :event }
    context "owner_id と引数の id が同じとき" do
      it "true を返す" do
        expect(event.created_by?(event.owner)).to be true 
      end
    end

    context "owner_id と引数の id が異なるとき" do
      let!(:another_user) { create :user }
      it "false を返す" do
        expect(event.created_by?(another_user)).to be false 
      end
    end

    context "引数の id が nil のとき" do
      it "false を返す" do
        expect(event.created_by?(nil)).to be false 
      end
    end
  end

  describe "#start_at_should_be_before_end_at" do
    context "start_at が end_at よりも前の場合" do
      let!(:event) { build :event }
      it "バリデーションが有効である" do
        expect(event).to be_valid
      end
    end

    context "start_at が end_at よりも後の場合" do
      let!(:start_at) { rand(1..30).days.from_now }
      let!(:end_at) {start_at - rand(1..30).hours}
      let!(:event) { FactoryBot.build(:event, start_at: start_at, end_at: end_at) }
      it "バリデーションが無効である" do
        expect(event).to be_invalid
      end
    end
  end
end
