require 'rails_helper'

  describe "Search for routes" do
    it "using key and valid route" do
      VCR.use_cassette('valid_route', re_record_interval: 1.days) do
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
    end

    it "long route" do
      VCR.use_cassette('long_route', re_record_interval: 1.days) do
        params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
        post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
        response_body = JSON.parse(response.body, symbolize_names: true)[:data]
        user_key = response_body[:attributes][:api_key]
        
        params = {:origin => "Los Angeles, CA", :destination => "Miami, FL", :api_key => user_key}
        post "/api/v0/road_trip", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
        response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      
        expect(response_body[:attributes]).to have_key(:start_city)
        expect(response_body[:attributes][:start_city]).to eq("Los Angeles, CA")
        expect(response_body[:attributes]).to have_key(:end_city)
        expect(response_body[:attributes][:end_city]).to eq("Miami, FL")
        expect(response_body[:attributes]).to have_key(:travel_time)
        expect(response_body[:attributes][:travel_time]).to_not eq("impossible route")
        expect(response_body[:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(response_body[:attributes][:weather_at_eta][:datetime]).to_not eq("")
        expect(response_body[:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(response_body[:attributes][:weather_at_eta][:temperature]).to_not eq("")
        expect(response_body[:attributes][:weather_at_eta]).to have_key(:condition)
        expect(response_body[:attributes][:weather_at_eta][:condition]).to_not eq("")
      end
    end

    it "using impossible route" do
      VCR.use_cassette('impossible_route', re_record_interval: 1.days) do
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