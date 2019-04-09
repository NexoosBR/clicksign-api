require "clicksign/api/version"

require "faraday"
require "base64"

begin
  require "dotenv/load"
  require "byebug"
rescue LoadError
end

require "clicksign/api/requests"
require "clicksign/api/batch"
require "clicksign/api/document"
require "clicksign/api/documents_signers"
require "clicksign/api/signer"
require "clicksign/api/notifier"


module Clicksign
  module API
    class << self
      attr_accessor :access_token, :production

      def configure
        yield(self)
      end

      def production?
        production || false
      end

      def url
        if production?
          'https://app.clicksign.com'
        else
          'https://sandbox.clicksign.com'
        end
      end
    end
  end
end
