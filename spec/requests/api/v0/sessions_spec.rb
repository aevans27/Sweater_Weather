require 'rails_helper'

  describe "Login as user" do
    it "using email and password" do
      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]

      params = {:email => "person@woohoo.com", :password => "abc123"}
      post "/api/v0/sessions", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      
      expect(response_body[:attributes]).to have_key(:email)
      expect(response_body[:attributes][:email]).to eq("person@woohoo.com")
      expect(response_body[:attributes]).to have_key(:api_key)
      expect(response_body[:attributes][:api_key]).to be_an(String)
      expect(response_body).to have_key(:type)
      expect(response_body[:type]).to eq("users")
      expect(response_body).to have_key(:id)
      expect(response_body[:id]).to be_an(Integer)
    end

    it "user doesn't exist" do 
      params = {:email => "person@woohoo.com", :password => "abc123"}
      post "/api/v0/sessions", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Bad Credentials")
    end

    it "empty values" do 
      params = {:email => "person@woohoo.com", :password => "abc123", :password_confirmation => "abc123"}
      post "/api/v0/users", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)[:data]
      params = {:email => "", :password => "abc123"}
      post "/api/v0/sessions", params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(404)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors]).to eq("Bad Credentials")
    end
  end