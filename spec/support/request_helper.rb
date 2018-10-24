module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
