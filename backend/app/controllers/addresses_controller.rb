class AddressesController < ApplicationController

  # 検索メソッド
  #
  # このメソッドは、住所に基づいてElasticsearchに対する検索クエリを実行します。
  # `params[:query]` に検索ワードを含む必要があります。結果はJSON形式で返されます。
  #
  # @param [String] query 検索クエリ
  # @param [Integer] page 検索結果のページ番号 (省略可能、デフォルトは1)
  # @param [Integer] per_page ページごとの結果数 (省略可能、デフォルトは10)
  # @return [JSON] 検索結果の配列をJSON形式で返します
  # @raise [ActionController::BadRequest] 検索クエリが空の場合
  # @raise [StandardError] Elasticsearchの検索が失敗した場合
  #
  # @example 検索クエリを指定した場合
  #   GET /search?query=東京都&page=1&per_page=10
  def search
    if params[:query].blank?
      render json: { error: "検索クエリが指定されていません" }, status: :bad_request
      return
    end

    begin
      Address.ensure_index_exists

      page = params[:page].to_i > 0 ? params[:page].to_i : 1
      per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
      from_value = (page - 1) * per_page

      results = Address.search({
        query: {
          match_phrase: {
            combined_field: params[:query]
          }
        },
        from: from_value,
        size: per_page
      })

      render json: results.records, status: :ok
    rescue => e
      render json: { error: "検索に失敗しました: #{e.message}" }, status: :unprocessable_entity
    end
  end

  # CSVインポートメソッド
  #
  # このメソッドは、CSVファイルをZIPから抽出し、データベースにインポートします。
  # データベーストランザクションが使用され、成功時にはElasticsearchのインデックスも更新されます。
  #
  # @return [JSON] 成功メッセージをJSON形式で返します
  # @raise [StandardError] ZIPファイルのダウンロードまたはCSVインポートに失敗した場合
  #
  # @example ZIPファイルからのCSVインポート
  #   POST /create
  def create
    begin
      csv_fetcher = CsvFetcherService.new
      csv_fetcher.download_zip
      csv_file_path = csv_fetcher.extract_csv_from_zip

      Address.transaction do
        Address.import_from_csv(csv_file_path)
      end

      Address.__elasticsearch__.index_exists? && Address.__elasticsearch__.delete_index!
      Address.__elasticsearch__.create_index!
      Address.import
      Address.__elasticsearch__.refresh_index!

      render json: { message: "CSVの取り込みが完了しました" }, status: :ok
    ensure
      File.delete(csv_file_path) if csv_file_path && File.exist?(csv_file_path)
    end
  rescue => e
    render json: { error: "CSVの取り込みに失敗しました: #{e.message}" }, status: :unprocessable_entity
  end
end
