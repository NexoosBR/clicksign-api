module Clicksign
  module API
    class Document
      extend Requests

      class << self
        def create(path:, file:, signers: nil, deadline_at: nil, auto_close: nil, locale: nil)
          content_base64 = Base64.encode64(File.read(file))

          body = { document: {
            path: path,
            content_base64: "data:application/pdf;base64,#{content_base64}"
          } }

          body.merge!(deadline_at: deadline_at) unless deadline_at.nil?
          body.merge!(auto_close: auto_close) unless auto_close.nil?
          body.merge!(locale: locale) unless locale.nil?
          body.merge!(signers: signers) unless signers.nil?

          request_path = '/api/v1/documents'

          response = post(request_path, body)

          json = JSON.parse(response.body, symbolize_names: true)

          if response.success?
            json[:document]
          else
            json[:errors]
          end
        end
      end
    end
  end
end
