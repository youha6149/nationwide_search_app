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
end
