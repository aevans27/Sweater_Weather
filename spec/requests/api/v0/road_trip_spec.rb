require 'rails_helper'

  describe "Search for routes" do
    it "using key and valid route" do
      map_response = File.read('spec/fixtures/mapquest_trip.json')
      weather_response = File.read('spec/fixtures/weather_call.json')
      stub_request(:post, "https://www.mapquestapi.com/directions/v2/route?key=fPSpsmN95gCyAZ0FrcpcjJhTvtIIS99k").
         with(
           body: "{\"locations\":[\"Cincinatti,OH\",\"Chicago,IL\"]}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: map_response, headers: {})

         stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=ef101d4dc8e546a4b62171509241301&q=41.88425000000014%20-87.6324550000007").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: weather_response, headers: {})

      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      user_key = response_body[:attributes][:api_key]
      
      params = {:origin => "Cincinatti,OH", :destination => "Chicago,IL", :api_key => user_key}
      post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
    
      expect(response_body[:attributes]).to have_key(:start_city)
      expect(response_body[:attributes][:start_city]).to eq("Cincinatti,OH")
      expect(response_body[:attributes]).to have_key(:end_city)
      expect(response_body[:attributes][:end_city]).to eq("Chicago,IL")
      expect(response_body[:attributes]).to have_key(:travel_time)
      expect(response_body[:attributes][:travel_time]).to_not eq("impossible route")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(response_body[:attributes][:weather_at_eta][:datetime]).to_not eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_body[:attributes][:weather_at_eta][:temperature]).to_not eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:condition)
      expect(response_body[:attributes][:weather_at_eta][:condition]).to_not eq("")
    end

    it "long route" do
      map_response = File.read('spec/fixtures/long_trip.json')
      weather_response = File.read('spec/fixtures/weather_call.json')
      stub_request(:post, "https://www.mapquestapi.com/directions/v2/route?key=fPSpsmN95gCyAZ0FrcpcjJhTvtIIS99k").
         with(
           body: "{\"locations\":[\"New York, NY\",\"Los Angeles, CA\"]}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: map_response, headers: {})

         stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=2&key=ef101d4dc8e546a4b62171509241301&q=34.05357300000072%20-118.24544800000619").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: weather_response, headers: {})

      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      user_key = response_body[:attributes][:api_key]
      
      params = {:origin => "New York, NY", :destination => "Los Angeles, CA", :api_key => user_key}
      post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
    
      expect(response_body[:attributes]).to have_key(:start_city)
      expect(response_body[:attributes][:start_city]).to eq("New York, NY")
      expect(response_body[:attributes]).to have_key(:end_city)
      expect(response_body[:attributes][:end_city]).to eq("Los Angeles, CA")
      expect(response_body[:attributes]).to have_key(:travel_time)
      expect(response_body[:attributes][:travel_time]).to_not eq("impossible route")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(response_body[:attributes][:weather_at_eta][:datetime]).to_not eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_body[:attributes][:weather_at_eta][:temperature]).to_not eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:condition)
      expect(response_body[:attributes][:weather_at_eta][:condition]).to_not eq("")
    end

    it "using impossible route" do
      bad_response = File.read('spec/fixtures/bad_route.json')
      stub_request(:post, "https://www.mapquestapi.com/directions/v2/route?key=fPSpsmN95gCyAZ0FrcpcjJhTvtIIS99k").
         with(
           body: "{\"locations\":[\"New York, NY\",\"London, UK\"]}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: bad_response, headers: {})

      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      user_key = response_body[:attributes][:api_key]
      
      params = {:origin => "New York, NY", :destination => "London, UK", :api_key => user_key}
      post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(response_body[:attributes]).to have_key(:start_city)
      expect(response_body[:attributes][:start_city]).to eq("New York, NY")
      expect(response_body[:attributes]).to have_key(:end_city)
      expect(response_body[:attributes][:end_city]).to eq("London, UK")
      expect(response_body[:attributes]).to have_key(:travel_time)
      expect(response_body[:attributes][:travel_time]).to eq("impossible route")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(response_body[:attributes][:weather_at_eta][:datetime]).to eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(response_body[:attributes][:weather_at_eta][:temperature]).to eq("")
      expect(response_body[:attributes][:weather_at_eta]).to have_key(:condition)
      expect(response_body[:attributes][:weather_at_eta][:condition]).to eq("")
    end

    it "user doesn't exist" do 
      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      user_key = response_body[:attributes][:api_key]
      
      params = {:origin => "Cincinatti,OH", :destination => "Chicago,IL", :api_key => ""}
      post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Bad Credentials")
    end

    it "missing values" do 
      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      user_key = response_body[:attributes][:api_key]
      
      params = {:origin => "New York, NY", :api_key => user_key}
      post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Bad Credentials")
    end
  end