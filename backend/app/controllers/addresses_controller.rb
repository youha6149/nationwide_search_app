class AddressesController < ApplicationController
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

  def create
    begin
      csv_fetcher = CsvFetcherService.new
      csv_file_path = csv_fetcher.extract_csv_from_zip

      Address.transaction do
        Address.import_from_csv(csv_file_path)
        Address.ensure_index_exists
      end

      render json: { message: "CSVの取り込みが完了しました" }, status: :ok
    ensure
      File.delete(csv_file_path) if csv_file_path && File.exist?(csv_file_path)
    end
  rescue => e
    render json: { error: "CSVの取り込みに失敗しました: #{e.message}" }, status: :unprocessable_entity
  end
end
