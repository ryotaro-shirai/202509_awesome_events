require 'rails_helper'

RSpec.describe "Statuses", type: :request do
  describe "GET /status" do
    context '/statusにアクセスした時' do
      let(:expected_res_body) { {status: 'ok'}.to_json }
      it '正しいレスポンスが返却されること' do
        get "/status"
        expect(response).to have_http_status(:success)
        expect(response.body).to eq expected_res_body
        expect(response.media_type).to eq "application/json"
      end
    end
  end
end
