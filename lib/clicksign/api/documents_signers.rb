module Clicksign
  module API
    class DocumentsSigners
      extend Requests

      REQUEST_PATH = '/api/v1/lists/'
      ATTRIBUTES = [
        :document_key, :signer_key, :sign_as
      ]

      class << self
        def create(token:, params: {})
          post(
            REQUEST_PATH,
            body(params),
            token
          )
        end

        def batch_create(token:, batch:)
          batch.map do |params|
            create(token: token, params: params)
          end
        end

        def body(params)
          list = ATTRIBUTES.each.with_object({}) do |key, hash|
            hash[key] = params[key] if params.has_key?(key)
          end

          body = { list: list }
        end
      end
    end
  end
end
