require "rails_helper"

RSpec.describe Image do
  it "exists" do
    attrs = {
      id: nil,
      type: "image",
      photos:[{url: "photo.url", photographer: "test"}],
    }

    image = Image.new(attrs, "here")

    expect(image).to be_a Image
    expect(image.id).to eq(nil)
    expect(image.type).to eq("image")
    expect(image.image).to eq({
      location: "here",
        image_url: "photo.url",
        credit: {
          source: "pexels.com",
          author: "test",
          logo: "https://images.pexels.com/lib/api/pexels-white.png"
        }
    })
  end
end