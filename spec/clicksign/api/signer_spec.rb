require 'spec_helper'

RSpec.describe Clicksign::API::Signer do
  describe '.path_for' do
    it {
      expect(described_class.path_for('123')).to \
        eq('/api/v1/documents/123/signers/')
    }
  end

  describe '.body' do
    context 'single signer' do
      let(:params) {
        {
          email: 'email',
          sign_as: 'sign_as',
          auths: ['auths'],
          name: 'name',
          documentation: 'documentation',
          birthday: 'birthday',
          has_documentation: 'has_documentation',
          phone_number: 'phone_number',
          send_email: 'send_email',
          message: 'message',
          url: 'url',
          invalid: 'invalid'
        }
      }

      let(:expected) {
        {
          signers: [
            {
              email: 'email',
              sign_as: 'sign_as',
              auths: ['auths'],
              name: 'name',
              documentation: 'documentation',
              birthday: 'birthday',
              has_documentation: 'has_documentation',
              phone_number: 'phone_number',
              send_email: 'send_email',
              message: 'message',
              url: 'url'
            }
          ]
        }
      }

      it {
        expect(
          described_class.body([params])
        ).to eq(expected)
      }
    end

    context 'multiple signers' do
      let(:params) {
        {
          email: 'email',
          sign_as: 'sign_as',
          auths: ['auths'],
          send_email: 'send_email'
        }
      }

      let(:expected) {
        {
          signers: [
            {
              email: 'email',
              sign_as: 'sign_as',
              auths: ['auths'],
              send_email: 'send_email'
            },
            {
              email: 'email',
              sign_as: 'sign_as',
              auths: ['auths'],
              send_email: 'send_email'
            }
          ]
        }
      }

      it {
        expect(
          described_class.body([params, params])
        ).to eq(expected)
      }
    end
  end

  describe '.create' do
    context 'valid document key and params' do
      context 'single signer' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Signer.create/basic-request') do
            described_class.create(
              'de3b4892-4cab-45f3-b84c-b0fb58b2d3e6',
              {
                email: 'francisco+teste@nexoos.com.br',
                sign_as: 'sign',
                auths: ['email'],
                send_email: true
              }
            )
          end
        end

        it { expect(json[:document][:key]).to eq('de3b4892-4cab-45f3-b84c-b0fb58b2d3e6') }
        it { expect(json[:document][:signers][0][:list_key]).to eq('8b426350-a5b1-447e-a33b-ec7e1e1eeb03') }
        it { expect(json[:document][:signers][0][:key]).to eq('258cb328-5928-4a7d-a8fd-2b7cfc221ab3') }
      end

      context 'multiple signers' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::Signer.create/multiple-signers-request') do
            described_class.create(
              'de3b4892-4cab-45f3-b84c-b0fb58b2d3e6',
              {
                email: 'francisco+teste@nexoos.com.br',
                sign_as: 'sign',
                auths: ['email'],
                send_email: true
              }, {
                email: 'lucas+teste@nexoos.com.br',
                sign_as: 'sign',
                auths: ['email'],
                send_email: true
              }
            )
          end
        end

        it { expect(json[:document][:key]).to eq('de3b4892-4cab-45f3-b84c-b0fb58b2d3e6') }
        it { expect(json[:document][:signers][0][:list_key]).to eq('8b426350-a5b1-447e-a33b-ec7e1e1eeb03') }
        it { expect(json[:document][:signers][0][:key]).to eq('258cb328-5928-4a7d-a8fd-2b7cfc221ab3') }
        it { expect(json[:document][:signers][1][:list_key]).to eq('4dd87512-6342-4a4e-b35b-0eb50bf75d07') }
        it { expect(json[:document][:signers][1][:key]).to eq('c8d249c7-0fa2-4d16-aa40-1fae574bf8ec') }
      end
    end
  end
end
