RSpec.describe Clicksign::Api do
  it 'has a version number' do
    expect(Clicksign::Api::VERSION).not_to eq('0.0.1')
  end

  describe '.configure' do
    context 'sandbox' do
      before do
        Clicksign::API.configure do |config|
          config.access_token = '123'
        end
      end

      it { expect(Clicksign::API.access_token).to eq('123') }
      it { expect(Clicksign::API.url).to eq('https://sandbox.clicksign.com') }
    end

    context 'production' do
      before do
        Clicksign::API.configure do |config|
          config.production = true
          config.access_token = '321'
        end
      end

      it { expect(Clicksign::API.access_token).to eq('321') }
      it { expect(Clicksign::API.url).to eq('https://app.clicksign.com') }
    end
  end
end
