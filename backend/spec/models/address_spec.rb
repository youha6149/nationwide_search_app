require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:csv_cp932_file_path) { Rails.root.join('spec/fixtures/test_addresses_cp932.csv') }
  let(:invalid_csv_file_path) { Rails.root.join('spec/fixtures/invalid_test_addresses.csv') }

  describe '.import_from_csv' do
    context 'when the CSV file is valid' do
      it 'creates address records from the CSV file' do
        expect { Address.import_from_csv(csv_cp932_file_path) }.to change { Address.count }.by(3)

        address = Address.first
        expect(address.prefecture).to eq('北海道')
        expect(address.city).to eq('札幌市中央区')
      end
    end

    context 'when there is an invalid record' do
      it 'logs the error but continues processing' do
        expect {
          Address.import_from_csv(invalid_csv_file_path)
        }.to output(/Failed to save record/).to_stdout
      end
    end
  end
end
