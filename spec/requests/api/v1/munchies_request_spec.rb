require 'rails_helper'

describe " Munchies API" do
  describe "happy paths" do
    it "returns a specified food type for a location in JSON" do
      origin = 'denver,co'
      destination = 'pueblo,co'
      food = 'chinese'

      get "/api/v1/munchies?start=#{origin}&end=#{destination}&food=#{food}"
      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
