module Clicksign
  module API
    class Document
      extend Requests

      REQUEST_PATH = '/api/v1/documents/'

      class << self
        def create(params = {})
          post(REQUEST_PATH, body(params))
        end

        def find(key)
          get(REQUEST_PATH + key)
        end

        def body(params)
          document = [:path, :deadline_at, :auto_close, :locale, :signers].each.with_object({}) do |key, hash|
            hash[key] = params[key] if params.has_key?(key)
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
