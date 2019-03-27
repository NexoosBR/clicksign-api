require 'spec_helper'

RSpec.describe Clicksign::API::DocumentsSigners do
  describe '.body' do
    let(:params) {
      {
        email: 'email',
        auths: ['auths'],
        name: 'name',
        documentation: 'documentation',
        birthday: 'birthday',
        has_documentation: 'has_documentation',
        phone_number: 'phone_number',
        delivery: 'delivery',
        message: 'message',
        url: 'url',
        invalid: 'invalid',
        document_key: 'document_key',
        signer_key: 'signer_key',
        sign_as: 'sign_as'

      }
    }

    let(:expected) {
      {
        list: {
          document_key: 'document_key',
          signer_key: 'signer_key',
          sign_as: 'sign_as'
        }
      }
    }

    it {
      expect(
        described_class.body(params)
      ).to eq(expected)
    }
  end

  describe '.create' do
    context 'valid document key and params' do
      context 'single signer' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::DocumentsSigners.create/basic-request') do
            described_class.create(
              {
                document_key: '28343efd-dccb-4e7a-9989-49e792b3c266',
                signer_key: '6fa5fc10-dcbe-4bae-a361-0350ea44fb5d',
                sign_as: 'party'
              }
            )
          end
        end

        it { expect(json[:list][:key]).to eq('178a3ab2-3c06-4431-975a-86b0b99d51c5') }
      end
    end
  end
end
