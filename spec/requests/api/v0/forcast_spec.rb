require 'rails_helper'

  describe "Get stuff" do
    it "find markets by state city" do
      get "/api/v0/forecast?location=cincinatti,oh"
      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names: true)
      require 'pry';binding.pry
    end
  end