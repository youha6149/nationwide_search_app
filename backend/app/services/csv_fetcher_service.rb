require 'open-uri'
require 'zip'

class CsvFetcherService
  def initialize(url="http://jusyo.jp/downloads/new/csv/csv_zenkoku.zip", storage_path=Rails.root.join('tmp'))
    @url = url
    @storage_path = storage_path
    @zip_path = Rails.root.join('tmp', 'csv_zenkoku.zip')
  end

  def download_zip
    zip_data = URI.open(@url).read
    File.open(@zip_path, 'wb') { |file| file.write(zip_data) }
  rescue => e
    Rails.logger.error("Failed to download zip file: #{e.message}")
    raise
  end

  def extract_csv_from_zip
    extracted_csv_path = extract_csv(@zip_path)
    extracted_csv_path
  rescue => e
    Rails.logger.error("Failed to extract CSV from zip: #{e.message}")
    raise
  ensure
    File.delete(@zip_path) if File.exist?(@zip_path)
  end

  private
  def extract_csv(zip_path)
    extracted_csv_path = nil
    Zip::File.open(zip_path) do |zip_file|
      zip_file.each do |entry|
        if entry.name.end_with?('.csv')
          extracted_csv_path = Rails.root.join('tmp', entry.name)
          entry.extract(extracted_csv_path) { true }
        end
      end
    end
    extracted_csv_path
  end
end
