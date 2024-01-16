require 'rails_helper'

describe WeatherService do
  context "class methods" do
    context "#weather_details" do
      it "returns info on a route" do
        VCR.use_cassette('weather') do
          start = {results:[{locations: [{latLng:{lat: 36.171928, lng: -115.140011}}]}]}
          l = Location.new(start)
          w = WeatherService.new.weather_details(l)
          expect(w).to be_a Hash
          expect(w[:forecast][:forecastday].last[:hour]).to be_an Array
        end
      end
    end
  end
end