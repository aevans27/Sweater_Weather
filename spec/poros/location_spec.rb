require "rails_helper"

RSpec.describe Location do
  it "exists" do
    attrs = {
      results:[{locations: [{latLng:{lat: 22, lng: 33}}]}]
    }

    l = Location.new(attrs)

    expect(l).to be_a Location
    expect(l.lat).to eq(22)
    expect(l.lng).to eq(33)
  end
end