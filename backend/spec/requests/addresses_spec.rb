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

  describe "POST /create" do
    # NOTE: ElasticSearchへのアクセス(create, delete, import, refresh)が実行できるかを確認するためのテスト
    let(:csv_fetcher) { instance_double(CsvFetcherService) }
    let(:csv_file_path_in_fixture) { Rails.root.join('spec', 'fixtures', 'zenkoku_cp932_head3.csv') }
    let(:test_csv_file_path) { Rails.root.join('tmp', 'zenkoku_cp932_head3.csv') }

    before do
      csv_fetcher = CsvFetcherService.new
      allow(CsvFetcherService).to receive(:new).and_return(csv_fetcher)
      # NOTE: import_from_csvの引数のみをモックにすることはできない
      allow(csv_fetcher).to receive(:extract_csv_from_zip).and_return(test_csv_file_path)
    end

    it "creates index and imports data from CSV" do
      # NOTE: createメソッドの最後にcsvが削除されるため、テスト用のファイルをコピーしておく
      FileUtils.cp(csv_file_path_in_fixture, test_csv_file_path)

      post create_path
      expect(response).to have_http_status(:ok)

      expect(Address.__elasticsearch__.index_exists?).to be_truthy
      expect(Address.search(query: { match: { combined_field: "北海道" }}).records.size).to eq(3)

      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq("CSVの取り込みが完了しました")

    end

    it "returns error when CSV import fails" do
      # Note: 対象CSVが存在しないことが原因のエラーが発生した場合のテスト
      post create_path
      expect(response).to have_http_status(:unprocessable_entity)

      json_response = JSON.parse(response.body)
      expect(json_response['error']).to include("CSVの取り込みに失敗しました")
    end
  end
end
