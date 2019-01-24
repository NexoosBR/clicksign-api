Clicksign::API.configure do |config|
  config.access_token = ENV['CLICKSIGN_ACCESS_TOKEN']
  config.production = false
end
