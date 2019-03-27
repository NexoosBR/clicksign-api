module Clicksign
  module API
    class Notifier
      extend Requests

      REQUEST_PATH = '/api/v1/notifications'
      ATTRIBUTES = [:request_signature_key, :message, :url]

      class << self
        def notify(params = {})
          post(
            REQUEST_PATH,
            body(params)
          )
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
