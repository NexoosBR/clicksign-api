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
          response = post(
            REQUEST_PATH,
            body(params),
            token
          )
          parse(response)
        end

        def batch_create(token:, params:)
          params = params.transform_keys(&:to_sym)
          
          params[:batch].map do |single_params|
            create(token: token, params: single_params)
          end
        end

        def body(params)
          params = params.transform_keys(&:to_sym)

          list = ATTRIBUTES.each.with_object({}) do |key, hash|
            hash[key] = params[key] if params.has_key?(key)
          end

          body = { list: list }
        end

        def parse(response)
          if !response.body.empty?
            JSON.parse(response.body, symbolize_keys: true).merge(status: response.status)
          else
            { status: response.status }
          end
        end
      end
    end
  end
end
