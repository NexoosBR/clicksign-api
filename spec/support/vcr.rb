require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('CLICKSIGN_ACCESS_TOKEN') do
    ENV['CLICKSIGN_ACCESS_TOKEN']
  end
end
