require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:valid_params) { { query: '東京都' } }
  let(:invalid_params) { { query: '' } }

  describe 'GET #search' do
    context 'when search query is not provided' do
      it 'returns a bad request status and an error message' do
        get :search, params: invalid_params

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => '検索クエリが指定されていません' })
      end
    end

    context 'when search query is provided' do
      let!(:address1) { create(:address) }
      let!(:address2) { create(:address, :osaka) }

      before do
        allow(Address).to receive(:search).and_return(double('response', records: [address1, address2]))
      end

      it 'returns a success status and the correct search results for multiple addresses' do
        get :search, params: valid_params

        expect(response).to have_http_status(:ok)
        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to be_an(Array)
        expect(parsed_body.size).to eq(2)

        # 全てのフィールドをカバーする
        first_record = parsed_body.first
        expect(first_record).to include(
          'address_cd' => 105000000,
          'prefecture_cd' => 13,
          'city_cd' => 13103,
          'town_cd' => 131030000,
          'postal_code' => "105-0000",
          'business_flag' => false,
          'abolished_flag' => false,
          'prefecture' => "東京都",
          'prefecture_kana' => "トウキョウト",
          'city' => "港区",
          'city_kana' => "ミナトク",
          'town' => nil,
          'town_kana' => "　",
          'town_supplement' => "（該当なし）",
          'kyoto_street' => nil,
          'chome' => nil,
          'chome_kana' => nil,
          'supplement' => nil,
          'business_name' => nil,
          'business_name_kana' => nil,
          'business_address' => nil,
          'new_address_cd' => nil,
          'created_at' => "2024-09-15T08:20:55.666Z",
          'updated_at' => "2024-09-15T08:20:55.666Z"
        )

        second_record = parsed_body.second
        expect(second_record).to include(
          'address_cd' => 123456789,
          'prefecture_cd' => 27,
          'city_cd' => 27100,
          'town_cd' => 271000000,
          'postal_code' => "530-0000",
          'business_flag' => false,
          'abolished_flag' => false,
          'prefecture' => "大阪府",
          'prefecture_kana' => "オオサカフ",
          'city' => "大阪市",
          'city_kana' => "オオサカシ",
          'town' => nil,
          'town_kana' => "　",
          'town_supplement' => "（該当なし）",
          'kyoto_street' => nil,
          'chome' => nil,
          'chome_kana' => nil,
          'supplement' => nil,
          'business_name' => nil,
          'business_name_kana' => nil,
          'business_address' => nil,
          'new_address_cd' => nil,
          'created_at' => "2024-09-15T08:20:55.666Z",
          'updated_at' => "2024-09-15T08:20:55.666Z"
        )
      end
    end

    context 'when search throws an error' do
      before do
        allow(Address).to receive(:search).and_raise(StandardError.new('Elasticsearch error'))
      end

      it 'returns an unprocessable entity status and an error message' do
        get :search, params: valid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 'error' => '検索に失敗しました: Elasticsearch error' })
      end
    end
  end
end
