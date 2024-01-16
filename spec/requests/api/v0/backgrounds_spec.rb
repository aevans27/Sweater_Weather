require 'rails_helper'

  describe "Map api calls" do
    it "get weather from a location on successful call" do
      pexel_response = File.read('spec/fixtures/pexel_call.json')
      stub_request(:get, "https://api.pexels.com/v1/search?per_page=1&query=denver,co").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> "#{Rails.application.credentials.maps[:pexels_key]}",
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: pexel_response, headers: {})

      get "/api/v0/backgrounds?location=denver,co"
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response_body).to have_key(:id)
      expect(response_body[:id]).to eq(nil)
      expect(response_body).to have_key(:type)
      expect(response_body[:type]).to eq("image")
      expect(response_body[:attributes][:image]).to have_key(:location)
      expect(response_body[:attributes][:image][:location]).to eq("denver,co")
      expect(response_body[:attributes][:image]).to have_key(:image_url)
      expect(response_body[:attributes][:image][:image_url]).to be_an(String)
      expect(response_body[:attributes][:image][:credit]).to have_key(:source)
      expect(response_body[:attributes][:image][:credit][:source]).to be_an(String)
      expect(response_body[:attributes][:image][:credit]).to have_key(:author)
      expect(response_body[:attributes][:image][:credit][:author]).to be_an(String)
      expect(response_body[:attributes][:image][:credit]).to have_key(:logo)
      expect(response_body[:attributes][:image][:credit][:logo]).to eq("https://images.pexels.com/lib/api/pexels-white.png")
    end

    it "don't send location" do 
      get "/api/v0/backgrounds?location"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
    end
  end