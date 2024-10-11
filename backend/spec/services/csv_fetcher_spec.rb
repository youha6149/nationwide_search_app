require 'rails_helper'
require 'zip'
require 'webmock/rspec'
require 'kconv'

RSpec.describe CsvFetcherService, type: :service do
  let(:url) { 'http://usyo.jp/downloads/new/csv/csv_zenkoku.zip' }
  let(:storage_path) { Rails.root.join('tmp') }
  # NOTE: 以下二つのパスはテスト実行時に作成され、テスト後に削除される
  let(:zip_path) { Rails.root.join('tmp', 'csv_zenkoku.zip') }
  let(:csv_path) { Rails.root.join('tmp', 'csv_zenkoku.csv') }

  let(:utf8_csv_path) { Rails.root.join('spec', 'fixtures', 'zenkoku_utf8_head3.csv') }
  let(:valid_header_csv_path) { Rails.root.join('spec', 'fixtures', 'zenkoku_cp932_head3.csv') }
  let(:invalid_header_csv_path) { Rails.root.join('spec', 'fixtures', 'invalid_zenkoku_cp932_head3_drop_prefecture.csv') }

  subject { described_class.new(url, storage_path) }

  describe '#download_zip' do
    before do
      stub_request(:get, url).to_return(body: File.read('spec/fixtures/csv_zenkoku.zip'), status: 200)
    end

    it 'downloads the zip file' do
      subject.download_zip
      # NOTE: `stub_request`はファイルのダウンロード処理自体をモックしているだけで、
      # ファイルの保存先や保存処理そのものをモックしているわけではないので確認するのはzip_pathで問題ない
      expect(File.exist?(zip_path)).to be_truthy
    end

    it 'raises an OpenURI::HTTPError if the download fails' do
      stub_request(:get, url).to_return(status: 404)
      expect { subject.download_zip }.to raise_error(OpenURI::HTTPError)
    end
  end

  describe '#extract_csv_from_zip' do
    before do
      entry_mock = double('entry', name: 'csv_zenkoku.csv', extract: true)
      zip_file_mock = double('zip_file')

      allow(Zip::File).to receive(:open).with(zip_path).and_yield(zip_file_mock)
      allow(zip_file_mock).to receive(:each).and_yield(entry_mock)
      allow_any_instance_of(CsvFetcherService).to receive(:check_encoding).and_return(true)
      allow_any_instance_of(CsvFetcherService).to receive(:check_headers).and_return(true)
    end

    it 'extracts the CSV from the zip file and returns the path' do
      extracted_path = subject.extract_csv_from_zip
      expect(extracted_path).to eq(csv_path)
    end

    it 'logs an error and raises an exception if extraction fails' do
      allow(Zip::File).to receive(:open).and_raise(Zip::Error)
      expect(Rails.logger).to receive(:error).with(/Failed to extract CSV from zip:/)
      expect { subject.extract_csv_from_zip }.to raise_error(Zip::Error)
    end
  end

  describe '#extract_csv' do
    before do
      entry_mock = double('entry', name: 'csv_zenkoku.csv', extract: true)
      zip_file_mock = double('zip_file')

      allow(Zip::File).to receive(:open).with(zip_path).and_yield(zip_file_mock)
      allow(zip_file_mock).to receive(:each).and_yield(entry_mock)
    end

    it 'returns the correct extracted CSV path' do
      extracted_path = subject.send(:extract_csv, zip_path)
      expect(extracted_path).to eq(csv_path)
    end
  end

  describe '#check_encoding' do
    context 'when encoding is CP932' do
      before do
        allow(File).to receive(:open).with(csv_path, "r:CP932").and_yield(StringIO.new("CP932 encoded text".encode("CP932")))
      end

      it 'does not raise any error if the CSV is encoded in CP932' do
        expect { subject.send(:check_encoding, csv_path) }.not_to raise_error
      end
    end

    context 'when encoding is not CP932' do
      it 'raises an error if the CSV is not encoded in CP932' do
        expect { subject.send(:check_encoding, utf8_csv_path) }.to raise_error(RuntimeError, /Encoding error: Expected CP932 encoding/)
      end
    end
  end

  describe '#check_headers' do
    it 'does not raise any error if the CSV headers are valid' do
      expect { subject.send(:check_headers, valid_header_csv_path) }.not_to raise_error
    end

    it 'raises an error if the CSV headers are invalid or missing' do
      expect { subject.send(:check_headers, invalid_header_csv_path) }.to raise_error(RuntimeError, /Invalid CSV headers:/)
    end
  end
end
