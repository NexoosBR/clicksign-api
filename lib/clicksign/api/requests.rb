module Clicksign
  module API
    module Requests
      def post(request_path, body, token)
        response = conn.post do |req|
          req.url request_path, { access_token: Clicksign::API.credentials[token] }
          req.headers['Content-Type'] = 'application/json'
          req.body = body.to_json
        end
        
        parse(response)
      end

      def get(request_path, token)
        response = conn.get do |req|
          req.url request_path, { access_token: Clicksign::API.credentials[token] }
          req.headers['Content-Type'] = 'application/json'
        end
        
        parse(response)
      end
      
      private

      def conn
        @conn ||= Faraday.new(url: Clicksign::API.url)
      end
      
      def parse(response)
        if !response.body.empty?
          JSON.parse(response.body, symbolize_keys: true).merge(status: response.status)
        else
          { status: response.status }
        end
      end
    end
  end
end