module Clicksign
  module API
    class WhatsappNotifier
      extend Requests

      REQUEST_PATH = '/api/v1/notify_by_whatsapp'
      ATTRIBUTES = [:request_signature_key]

      class << self
        def notify(token:, params: {})
          post(
            REQUEST_PATH,
            body(params),
            token
          )
        end

        def body(params)
          params = params.transform_keys(&:to_sym)

          ATTRIBUTES.each.with_object({}) do |attribute, hash|
            hash[attribute] = params[attribute] if params.has_key?(attribute)
          end
        end
      end
    end
  end
end
