module Clicksign
  module API
    class Signer
      extend Requests

      REQUEST_PATH = '/api/v1/signers/'
      ATTRIBUTES = [
        :email, :auths, :name, :documentation, :birthday,
        :has_documentation, :phone_number, :delivery
      ]

      class << self
        def create(token:, params:)
          post(
            REQUEST_PATH,
            body(params),
            token
          )
        end

        def body(params)
          params = params.transform_keys(&:to_sym)

          signer = ATTRIBUTES.each.with_object({}) do |key, hash|
            hash[key] = params[key] if params.has_key?(key)
          end

          body = { signer: signer }
        end
      end
    end
  end
end
