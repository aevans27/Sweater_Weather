require 'rails_helper'

describe LocationService do
  context "class methods" do
    context "#location_details" do
      it "returns location lat and lng" do
        VCR.use_cassette('coordinates') do
          location = LocationService.new.location_details("denver, co")
          expect(location).to be_a Hash
          
          expect(location[:results]).to be_an Array
          expect(location[:results].first[:locations].first[:latLng][:lat]).to be_an(Float)
          expect(location[:results].first[:locations].first[:latLng][:lng]).to be_an(Float)
        end
      end
    end
  end
end