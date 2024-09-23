require "csv"

class Address < ApplicationRecord
  include Elasticsearch::Model

  index_name "addresses_#{Rails.env}"

  settings analysis: {
    tokenizer: {
      ngram_tokenizer: {
        type: "ngram",
        min_gram: 2,
        max_gram: 2,
        token_chars: ["letter", "digit"]
      }
    },
    analyzer: {
      ngram_analyzer: {
        tokenizer: "ngram_tokenizer",
        filter: ["lowercase"]
      }
    }
  } do
    mappings dynamic: false do
      indexes :combined_field, type: "text", analyzer: "ngram_analyzer"
    end
  end

  # memo: 現時点(2024/09/22)ではmodelにデータが存在する前提
  def self.ensure_index_exists
    unless self.__elasticsearch__.index_exists?
      self.__elasticsearch__.create_index!
      self.import
    end
  end

  def as_indexed_json(options = {})
    {
      combined_field: "#{prefecture}#{city}#{town}#{kyoto_street}#{chome}#{business_name}#{business_address}"
    }
  end

  # memo: 現在はpandasで読み込んだcsvを利用している
  def self.import_from_csv(file_path)
    CSV.foreach(file_path, encoding: "CP932:UTF-8", headers: true) do |row|
      begin
        # memo: 必須の列が存在しない場合はエラーログを出力して次の行に進む
        required_columns = ["都道府県", "市区町村", "町域", "京都通り名", "字丁目", "事業所名", "事業所住所", "郵便番号"]
        missing_columns = required_columns.select { |column| !row.headers.include?(column) }

        if missing_columns.any?
          puts "Failed to save record due to missing columns: #{missing_columns.join(', ')}"
          next
        end

        Address.create!(
          address_cd: row["住所CD"].to_i,
          prefecture_cd: row["都道府県CD"].to_i,
          city_cd: row["市区町村CD"].to_i,
          town_cd: row["町域CD"].to_i,
          postal_code: row["郵便番号"],
          business_flag: row["事業所フラグ"],
          abolished_flag: row["廃止フラグ"],
          prefecture: row["都道府県"],
          prefecture_kana: row["都道府県カナ"],
          city: row["市区町村"],
          city_kana: row["市区町村カナ"],
          town: row["町域"],
          town_kana: row["町域カナ"],
          town_supplement: row["町域補足"],
          kyoto_street: row["京都通り名"],
          chome: row["字丁目"],
          chome_kana: row["字丁目カナ"],
          supplement: row["補足"],
          business_name: row["事業所名"],
          business_name_kana: row["事業所名カナ"],
          business_address: row["事業所住所"],
        )
      rescue => e
        puts "Failed to save record: #{row.inspect}"
        puts "Error: #{e.message}"
      end
    end
  end
end
