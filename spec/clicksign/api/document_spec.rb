require 'spec_helper'

RSpec.describe Clicksign::API::Document do
  let(:file) { file_fixture('pdf-sample.pdf') }

  describe '.create' do
    context 'a valid request' do
      context 'with only required parameters' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Document.create/basic-request') do
            described_class.create(
              path: '/teste/teste.pdf',
              file: file
            )
          end
        end

        it { expect(json[:document][:key]).to eq('ae7618d4-3958-4d7d-ade3-59def0d1288d') }
      end

      context 'with all available parameters' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Document.create/complete-request') do
            described_class.create(
              path: '/teste/teste.pdf',
              file: file,
              deadline_at: '2019-03-28T14:30:59-03:00',
              auto_close: false,
              locale: 'en-US'
            )
          end
        end

        it { expect(json[:document][:key]).to eq('28343efd-dccb-4e7a-9989-49e792b3c266') }
      end
    end

    context 'request with error' do
      context 'invalid path error' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Document.create/invalid-path') do
            described_class.create(
              path: '/teste',
              file: file
            )
          end
        end

        it { expect(json[:errors]).to eq(['Nome do arquivo não contém mimetype válido']) }
      end
    end

    context 'request with invalid access_token' do
      before do
        allow(Clicksign::API).to receive(:access_token).and_return('123')
      end

      let(:response) do
        VCR.use_cassette('Clicksign::API::Document.create/invalid-token') do
          described_class.create(path: '/teste/teste.pdf', file: file)
        end
      end

      it { expect(json[:errors]).to eq(['Access Token inválido']) }
    end
  end

  describe '.find' do
    context 'valid key' do
      let(:response) do
        VCR.use_cassette('Clicksign::API::Document.find/valid-key') do
          described_class.find('ae7618d4-3958-4d7d-ade3-59def0d1288d')
        end
      end

      it { expect(json[:document][:key]).to eq('ae7618d4-3958-4d7d-ade3-59def0d1288d') }
    end

    context 'invalid key' do
      let(:response) do
        VCR.use_cassette('Clicksign::API::Document.find/invalid-key') do
          described_class.find('WRONG')
        end
      end

      it { expect(json[:errors]).to eq(['Documento não encontrado']) }
    end
  end
end
