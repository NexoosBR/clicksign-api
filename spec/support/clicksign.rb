file_path = File.expand_path('../../fixtures/credentials.yml', __FILE__)
credentials = YAML.load(ERB.new(File.read(file_path)).result)

Clicksign::API.configure do |config|
  config.credentials = credentials
  config.production = false
end
