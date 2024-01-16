require 'rails_helper'

describe RoadTripService do
  context "class methods" do
    context "#trip_details" do
      it "returns info on a route" do
        VCR.use_cassette('trip') do
          trip = RoadTripService.new.trip_details("las vegas, nv", "miami, fl")
          expect(trip).to be_a Hash
          expect(trip[:route][:legs]).to be_an Array
          expect(trip[:route][:legs].first[:maneuvers].last[:startPoint][:lat]).to be_an(Float)
          expect(trip[:route][:legs].first[:maneuvers].last[:startPoint][:lng]).to be_an(Float)
          expect(trip[:route][:formattedTime]).to be_an(String)
        end
      end
    end
  end
end