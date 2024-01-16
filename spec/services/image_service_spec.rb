require 'rails_helper'

describe ImageService do
  context "class methods" do
    context "#image_details" do
      it "returns details on search" do
        VCR.use_cassette('images') do
          i = ImageService.new.image_details("denver, co")
          expect(i).to be_a Hash
          expect(i[:photos]).to be_an Array
          expect(i[:photos].first[:url]).to be_an(String)
          expect(i[:photos].first[:photographer]).to be_an(String)
        end
      end
    end
  end
end