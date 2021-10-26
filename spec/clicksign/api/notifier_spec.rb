require 'spec_helper'

RSpec.describe Clicksign::API::Notifier do
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
        request_signature_key: 'request_signature_key'
      }
    }

    let(:expected) {
      {
        request_signature_key: 'request_signature_key',
        message: 'message',
        url: 'url'
      }
    }

    it {
      expect(
        described_class.body(params)
      ).to eq(expected)
    }
  end

  describe '.notify' do
    context 'valid document key and params' do
      context 'single signer' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Notifier.notify/basic-request') do
            described_class.notify(
              token: 'valid_token',
              params:
              {
                request_signature_key: '793a0f7d-86cf-4bba-817b-86cd30b68ea0'
              }
            )
          end
        end

        it { expect(response.status).to eq(202) }
      end
    end
  end
end
