module Clicksign
  module API
    class WhatsappNotifier
      extend Requests

      REQUEST_PATH = '/api/v1/notify_by_whatsapp'
      ATTRIBUTES = [:request_signature_key]

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
