module Clicksign
  module API
    module Requests
      def post(request_path, body, token)
        conn.post do |req|
          req.url request_path, { access_token: Clicksign::API.credentials[token] }
          req.headers['Content-Type'] = 'application/json'
          req.body = body.to_json
        end
      end

      def get(request_path, token)
        conn.get do |req|
          req.url request_path, { access_token: Clicksign::API.credentials[token] }
          req.headers['Content-Type'] = 'application/json'
        end
      end

      def conn
        @conn ||= Faraday.new(url: Clicksign::API.url)
      end
    end
  end
end
