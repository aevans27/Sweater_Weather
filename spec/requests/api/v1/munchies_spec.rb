require 'rails_helper'

  describe "Resturant and Map api calls" do
    it "get information about a resturant on successful call" do
      yelp_response = File.read('spec/fixtures/yelp_call.json')
      weather_response = File.read('spec/fixtures/weather_call.json')

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?location=pueblo,co&term=italian").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{Rails.application.credentials.maps[:yelp_key]}",
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: yelp_response, headers: {})

         stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{Rails.application.credentials.maps[:weather_key]}&q=38.2645118031982%20-104.613206125796").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: weather_response, headers: {})

      get "/api/v1/munchies?destination=pueblo,co&food=italian"
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data][:type]).to be_an(String)
      expect(response_body[:data][:attributes]).to have_key(:destination_city)
      expect(response_body[:data][:attributes][:destination_city]).to be_an(String)
      expect(response_body[:data][:attributes][:forecast]).to have_key(:summary)
      expect(response_body[:data][:attributes][:forecast][:summary]).to be_an(String)
      expect(response_body[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(response_body[:data][:attributes][:forecast][:temperature]).to be_an(Float)
      expect(response_body[:data][:attributes][:restaurant]).to have_key(:name)
      expect(response_body[:data][:attributes][:restaurant][:name]).to be_an(String)
      expect(response_body[:data][:attributes][:restaurant]).to have_key(:address)
      expect(response_body[:data][:attributes][:restaurant][:address]).to be_an(String)
      expect(response_body[:data][:attributes][:restaurant]).to have_key(:rating)
      expect(response_body[:data][:attributes][:restaurant][:rating]).to be_an(Float)
      expect(response_body[:data][:attributes][:restaurant]).to have_key(:reviews)
      expect(response_body[:data][:attributes][:restaurant][:reviews]).to be_an(Integer)

      expect(response_body[:data][:attributes]).to_not have_key(:open_hours)
      expect(response_body[:data][:attributes]).to_not have_key(:catch_phrase)
    end

    it "don't send destination" do 
      get "/api/v1/munchies?food=italian"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
    end

    it "don't send destination" do 
      get "/api/v1/munchies?food=italian"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
    end

    it "don't send food" do 
      get "/api/v1/munchies?destination=pueblo,co"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
    end
  end