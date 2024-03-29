RSpec.describe Clicksign::API do
  it 'has a version number' do
    expect(Clicksign::API::VERSION).to eq('1.1.8.alpha')
  end

  describe '.configure' do
    let(:credentials) { { 'valid_token' => ENV['CLICKSIGN_ACCESS_TOKEN'] } }
    
    context 'sandbox' do
      before do
        Clicksign::API.configure do |config|
          config.credentials = credentials
        end
      end

      it { expect(Clicksign::API.credentials['valid_token']).to eq(ENV['CLICKSIGN_ACCESS_TOKEN']) }
      it { expect(Clicksign::API.url).to eq('https://sandbox.clicksign.com') }
    end

    context 'production' do
      before do
        Clicksign::API.configure do |config|
          config.production = true
          config.credentials = credentials
        end
      end

      it { expect(Clicksign::API.credentials['valid_token']).to eq(ENV['CLICKSIGN_ACCESS_TOKEN']) }
      it { expect(Clicksign::API.url).to eq('https://app.clicksign.com') }
    end
  end
end
