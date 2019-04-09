require 'spec_helper'

RSpec.describe Clicksign::API::Batch do
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
        document_keys: ['document_key', 'document_key2'],
        signer_key: 'signer_key',
        summary: 'summary',
        sign_as: 'sign_as'

      }
    }

    let(:expected) {
      {
        batch: {
          document_keys: ['document_key', 'document_key2'],
          signer_key: 'signer_key',
          summary: 'summary'
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
    context 'valid document keys and params' do
      context 'single signer' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Batch.create/basic-request') do
            described_class.create(
              {
                document_keys: ['28343efd-dccb-4e7a-9989-49e792b3c266'],
                signer_key: '6fa5fc10-dcbe-4bae-a361-0350ea44fb5d',
                summary: true
              }
            )
          end
        end

        it { expect(json[:batch][:key]).to eq('d98c9561-3750-4dab-a7a2-46676a148afd') }
      end
    end
  end
end
