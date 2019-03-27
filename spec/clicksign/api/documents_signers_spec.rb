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
                sign_as: 'intervening'
              }
            )
          end
        end

        it { expect(json[:list][:key]).to eq('721ff97f-83d7-44c8-92a0-7c7f287f73f6') }
      end
    end
  end

  describe '.batch_create' do
    context 'valid document key and params' do
      context 'single signer' do
        let(:response) do
          VCR.use_cassette('Clicksign::API::DocumentsSigners.create/batch-request') do
            described_class.batch_create(
              [
                {
                  document_key: '28343efd-dccb-4e7a-9989-49e792b3c266',
                  signer_key: '6fa5fc10-dcbe-4bae-a361-0350ea44fb5d',
                  sign_as: 'transferor'
                },
                {
                  document_key: '28343efd-dccb-4e7a-9989-49e792b3c266',
                  signer_key: '6fa5fc10-dcbe-4bae-a361-0350ea44fb5d',
                  sign_as: 'transferee'
                },
                {
                  document_key: '28343efd-dccb-4e7a-9989-49e792b3c266',
                  signer_key: '6fa5fc10-dcbe-4bae-a361-0350ea44fb5d',
                  sign_as: 'contractee'
                }
              ]
            )
          end
        end

        it do
          expect(JSON.parse(response[0].body)["list"]["key"]).to eq('8c5cf01d-09d2-474c-b9a1-b4ef6bc1b603')
          expect(JSON.parse(response[1].body)["list"]["key"]).to eq('4add9d39-54cb-44f3-88be-fb67ab45b0be')
          expect(JSON.parse(response[2].body)["list"]["key"]).to eq('bb1a4b55-cd16-4778-b2dc-9184160026b8')
        end
      end
    end
  end
end
