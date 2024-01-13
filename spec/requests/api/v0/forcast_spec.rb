require 'rails_helper'

  describe "Get stuff" do
    it "find markets by state city" do
      get "/api/v0/forecast?location=cincinatti,oh"
    end
  end