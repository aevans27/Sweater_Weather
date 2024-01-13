require 'rails_helper'

  describe "Map api calls" do
    it "get weather from a location on successful call" do
      map_response = File.read('spec/fixtures/mapquest_call.json')
      weather_response = File.read('spec/fixtures/weather_call.json')
      stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?inFormat=kvp&key=fPSpsmN95gCyAZ0FrcpcjJhTvtIIS99k&location=cincinatti,oh&outFormat=json").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: map_response, headers: {})

         stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=ef101d4dc8e546a4b62171509241301&q=39.10713%20-84.50413").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: weather_response, headers: {})

      get "/api/v0/forecast?location=cincinatti,oh"
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:data][:attributes][:daily_weather].count).to eq(5)
      expect(response_body[:data][:attributes][:hourly_weather].count).to eq(24)

      response_body[:data][:attributes][:daily_weather].each do |weather|
        expect(weather).to have_key(:date)
        expect(weather[:date]).to be_an(String)
        expect(weather).to have_key(:sunrise)
        expect(weather[:sunrise]).to be_an(String)
        expect(weather).to have_key(:sunset)
        expect(weather[:sunset]).to be_an(String)
        expect(weather).to have_key(:max_temp)
        expect(weather[:max_temp]).to be_an(Float)
        expect(weather).to have_key(:min_temp)
        expect(weather[:min_temp]).to be_an(Float)
        expect(weather).to have_key(:condition)
        expect(weather[:condition]).to be_an(String)
        expect(weather).to have_key(:icon)
        expect(weather[:icon]).to be_an(String)
        expect(weather).to_not have_key(:date_epoch)
      end

      response_body[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_an(String)
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_an(Float)
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_an(String)
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_an(String)
        expect(hour).to_not have_key(:wind_mph)
      end
    end

    it "don't send location" do 
      get "/api/v0/forecast"
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
    end

    # it "don't send bad location location" do 
    #   get "/api/v0/forecast?location=pie 33&badstuff=44"
    #   response_body = JSON.parse(response.body, symbolize_names: true)
    #   expect(response.status).to eq(404)
    #   expect(response_body).to have_key(:errors)
    # end
  end