require 'spec_helper'

RSpec.describe Clicksign::API::Signer do
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
        invalid: 'invalid'
      }
    }

    let(:expected) {
      {
        signer: {
          email: 'email',
          auths: ['auths'],
          name: 'name',
          documentation: 'documentation',
          birthday: 'birthday',
          has_documentation: 'has_documentation',
          phone_number: 'phone_number',
          delivery: 'delivery'
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
          VCR.use_cassette('Clicksign::API::Signer.create/basic-request') do
            described_class.create(
              token: 'valid_token',
              params:
              {
                email: 'francisco+teste@nexoos.com.br',
                auths: ['email'],
                delivery: 'email'
              }
            )
          end
        end

        it { expect(json[:signer][:key]).to eq('6fa5fc10-dcbe-4bae-a361-0350ea44fb5d') }
      end
    end
  end
end
