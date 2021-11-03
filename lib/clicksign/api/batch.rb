module Clicksign
  module API
    class Batch
      extend Requests

      REQUEST_PATH = '/api/v1/batches'
      ATTRIBUTES = [:signer_key, :document_keys, :summary]

      class << self
        def create(token:, params:  {})
          post(
            REQUEST_PATH,
            body(params),
            token,
          )
        end

        def body(params)
          params = params.transform_keys(&:to_sym)

          batch = ATTRIBUTES.each.with_object({}) do |attribute, hash|
            hash[attribute] = params[attribute] if params.has_key?(attribute)
          end

          body = { batch: batch }
        end
      end
    end
  end
end
