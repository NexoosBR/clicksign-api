module Clicksign
  module API
    class Notifier
      extend Requests

      REQUEST_PATH = '/api/v1/signers/:key/notify'
      ATTRIBUTES = [:message]

      class << self
        def notify(document_key, params = {})
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
          ATTRIBUTES.each.with_object({}) do |attribute, hash|
            hash[attribute] = params[attribute] if params.has_key?(attribute)
          end
        end
      end
    end
  end
end
