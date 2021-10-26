require 'spec_helper'

RSpec.describe Clicksign::API::WhatsappNotifier do
  describe '.body' do
    let(:params) {
      {
        email: 'email',
        auths: ['whatsapp'],
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
          VCR.use_cassette('Clicksign::API::WhatsappNotifier.notify/basic-request') do
            described_class.notify(
              token: 'valid_token',
              params:
              {
                request_signature_key: '6ebb594d-c414-4e66-b513-27536ecf526e'
              }
            )
          end
        end

        it { expect(response.status).to eq(202) }
      end
    end
  end
end
