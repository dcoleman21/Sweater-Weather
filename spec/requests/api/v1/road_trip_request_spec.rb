require 'rails_helper'

describe "Road Trip API" do
  describe  "happy path" do
    it "returns road trip info in JSON format" do
      origin = 'Arvada,CO'
      destination = 'Apollo Beach, FL'
      api_key = SecureRandom.hex

      User.create!( email: 'dani@example.com',
                    password: '1234',
                    password_confirmation: '1234',
                    api_key: api_key
                  )

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      request_body = {
        "origin": origin,
        "destination": destination,
        "api_key": api_key #70be3a7c67bf3b80453d64b3ee3eb857
      }

      distance_body = File.read('spec/fixtures/route_data_arvada_apollo_beach.json')
      stub_request(:get, "#{ENV['MAP_QUEST_URL']}directions/v2/route?key=#{ENV['MAP_QUEST_KEY']}&from=#{origin}&to=#{destination}").to_return(status: 200, body: distance_body, headers: {})

      coordinate_body = File.read('spec/fixtures/route_data_apollo_beach.json')
      stub_request(:get, "#{ENV['MAP_QUEST_URL']}geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=#{destination}").to_return(status: 200, body: coordinate_body, headers: {})

      weather_body = File.read('spec/fixtures/weather_data_apollo_beach.json')
      stub_request(:get, "#{ENV['OPEN_WEATHER_URL']}onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&exclude=minutely,alerts&lat=27.763584&lon=-82.40031&units=imperial").to_return(status: 200, body: weather_body, headers: {})

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry

    end
  end
end
