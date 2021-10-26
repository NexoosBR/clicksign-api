module Clicksign
  module API
    class Document
      extend Requests

      REQUEST_PATH = '/api/v1/documents/'
      ATTRIBUTES = [:path, :deadline_at, :auto_close, :locale]

      class << self
        def create(token:, params: {})
          post(REQUEST_PATH, body(params), token)
        end

        def find(token:, key:)
          get(REQUEST_PATH + key, token)
        end

        def body(params)
          document = ATTRIBUTES.each.with_object({}) do |attribute, hash|
            hash[attribute] = params[attribute] if params.has_key?(attribute)
          end

          if params.has_key?(:file)
            content_base64 = Base64.encode64(File.read(params[:file]))
            document[:content_base64] = "data:application/pdf;base64,#{content_base64}"
          end

          body = { document: document }
        end
      end
    end
  end
end
