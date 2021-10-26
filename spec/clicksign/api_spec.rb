RSpec.describe Clicksign::Api do
  it 'has a version number' do
    expect(Clicksign::Api::VERSION).to eq('1.0.1')
  end

  describe '.configure' do
    let(:credentials) { { 'foo' => 'abc' } }
    
    context 'sandbox' do
      before do
        Clicksign::API.configure do |config|
          config.credentials = credentials
        end
      end

      it { expect(Clicksign::API.credentials['foo']).to eq('abc') }
      it { expect(Clicksign::API.url).to eq('https://sandbox.clicksign.com') }
    end

    context 'production' do
      before do
        Clicksign::API.configure do |config|
          config.production = true
          config.access_token = credentials
        end
      end

      it { expect(Clicksign::API.credentials['foo']).to eq('abc') }
      it { expect(Clicksign::API.credentials['bar']).to eq('123') }
      it { expect(Clicksign::API.url).to eq('https://app.clicksign.com') }
    end
  end
end
