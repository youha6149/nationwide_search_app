class AddressesController < ApplicationController
  def search
    if params[:query].blank?
      render json: { error: "検索クエリが指定されていません" }, status: :bad_request
      return
    end

    begin
      results = Address.search({
        query: {
          match_phrase: {
            combined_field: params[:query]
          }
        }
      })

      render json: results.records, status: :ok
    rescue => e
      render json: { error: "検索に失敗しました: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
