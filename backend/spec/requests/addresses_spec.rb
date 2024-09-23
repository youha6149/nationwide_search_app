require 'rails_helper'

RSpec.describe "Addresses", :elasticsearch, type: :request do
  describe "GET /search" do
    let(:query) { "東京都" }
    let(:valid_params) { { query: query, page: 1, per_page: 10 } }

    it "returns search results for valid query" do
      get search_path, params: valid_params
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.size).to be > 0
      expect(json_response.first['prefecture']).to include(query)
    end

    it "returns error when query is missing" do
      get search_path, params: { query: "" }
      expect(response).to have_http_status(:bad_request)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq("検索クエリが指定されていません")
    end

    it "returns error when Elasticsearch fails" do
      allow(Address).to receive(:search).and_raise(StandardError, "Elasticsearch error")
      get search_path, params: valid_params
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include("検索に失敗しました")
    end
  end
end
