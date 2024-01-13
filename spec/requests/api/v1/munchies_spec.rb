require 'rails_helper'

  describe "Map api calls" do
    it "get weather from a location on successful call" do
      map_response = File.read('spec/fixtures/mapquest_call.json')
      weather_response = File.read('spec/fixtures/weather_call.json')
      # stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?inFormat=kvp&key=fPSpsmN95gCyAZ0FrcpcjJhTvtIIS99k&location=cincinatti,oh&outFormat=json").
      #    with(
      #      headers: {
      #     'Accept'=>'*/*',
      #     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #     'User-Agent'=>'Faraday v2.9.0'
      #      }).
      #    to_return(status: 200, body: map_response, headers: {})

      #    stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=ef101d4dc8e546a4b62171509241301&q=39.10713%20-84.50413").
      #    with(
      #      headers: {
      #     'Accept'=>'*/*',
      #     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #     'User-Agent'=>'Faraday v2.9.0'
      #      }).
      #    to_return(status: 200, body: weather_response, headers: {})

      get "/api/v1/munchies?destination=pueblo,co&food=italian"
      
    end
  end