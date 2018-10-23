require 'spec_helper'

RSpec.describe Clicksign::API::Document, vcr: true do
  let(:pdf) { file_fixture('pdf-sample.pdf') }
  let(:png) { file_fixture('1px.png') }

  let(:deadline_at) { '2018-06-28T14:30:59-03:00' }
  let(:auto_close) { false }
  let(:locale) { 'en-US' }

  describe '.create' do
    context 'basic valid request' do
      it 'creates a document with required attributes' do
        response = described_class.create(
          path: '/teste/teste.pdf',
          file: pdf
        )

        expect(response[:key]).to eq('5c06f555-7e3a-48b1-9f10-759406847076')
      end

      it 'creates a document with all attributes' do
        response = described_class.create(
          path: '/teste/teste.pdf',
          file: pdf,
          signers: [
            {
              email: 'francisco@nexoos.com.br',
              sign_as: 'sign',
              auths: 'email'
            }
          ],
          deadline_at: deadline_at,
          auto_close: auto_close,
          locale: locale
        )

        expect(response[:key]).to eq('47790cb0-1349-418c-91bf-914a360c6247')
      end
    end

    context 'request with invalid params' do
      it "can't create a invalid path" do
        response = described_class.create(
          path: '/teste',
          file: png
        )

        expect(response).to eq(['Nome do arquivo não contém mimetype válido'])
      end
    end

    context 'request with invalid access_token' do
      before do
        allow(Clicksign::API).to receive(:access_token).and_return('123')
      end

      it 'needs a valid access token' do
        response = described_class.create(
          path: '/teste/teste.pdf',
          file: pdf
        )

        expect(response).to eq(['Access Token inválido'])
      end
    end
  end
end
