module Clicksign
  module API
    class Signer
      extend Requests

      REQUEST_PATH = '/api/v1/documents/:key/signers/'
      ATTRIBUTES = [
        :email, :sign_as, :auths, :name, :documentation, :birthday,
        :has_documentation, :phone_number, :send_email, :message, :url
      ]

      class << self
        def create(document_key, *params)
          post(
            path_for(document_key),
            body(params)
          )
        end

        def path_for(document_key)
          REQUEST_PATH.dup.tap do |path|
            path[':key'] = document_key
          end
        end

        def body(params)
          signers = params.map do |signer_params|
            ATTRIBUTES.each.with_object({}) do |key, hash|
              hash[key] = signer_params[key] if signer_params.has_key?(key)
            end
          end

          body = { signers: signers }
        end
      end
    end
  end
end
