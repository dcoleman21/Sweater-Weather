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

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      roadtrip = JSON.parse(response.body, symbolize_names: true)

      expect(roadtrip).to be_a(Hash)
      expect(roadtrip).to have_key(:data)
      expect(roadtrip[:data]).to be_a(Hash)
      expect(roadtrip[:data]).to have_key(:id)
      expect(roadtrip[:data][:id]).to eq(nil)
      expect(roadtrip[:data]).to have_key(:type)
      expect(roadtrip[:data][:type]).to be_a(String)
      expect(roadtrip[:data][:type]).to eq('roadtrip')
      expect(roadtrip[:data]).to have_key(:attributes)
      expect(roadtrip[:data][:attributes]).to be_a(Hash)

      trip_attr = roadtrip[:data][:attributes]

      expect(trip_attr).to have_key(:start_city)
      expect(trip_attr[:start_city]).to be_a(String)
      expect(trip_attr).to have_key(:end_city)
      expect(trip_attr[:end_city]).to be_a(String)
      expect(trip_attr).to have_key(:travel_time)
      expect(trip_attr[:travel_time]).to be_a(String)
      expect(trip_attr).to have_key(:weather_at_eta)
      expect(trip_attr[:weather_at_eta]).to be_a(Hash)
      expect(trip_attr[:weather_at_eta]).to have_key(:temperature)
      expect(trip_attr[:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(trip_attr[:weather_at_eta]).to have_key(:conditions)
      expect(trip_attr[:weather_at_eta][:conditions]).to be_a(String)
    end

    it "returns 'impossible route' if the travel time is impossible in JSON format" do
      origin = 'New York, NY'
      destination = 'Perth, AUS'
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

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      roadtrip = JSON.parse(response.body, symbolize_names: true)
      trip_attr = roadtrip[:data][:attributes]

      expect(trip_attr).to have_key(:start_city)
      expect(trip_attr[:start_city]).to be_a(String)
      expect(trip_attr).to have_key(:end_city)
      expect(trip_attr[:end_city]).to be_a(String)
      expect(trip_attr).to have_key(:travel_time)
      expect(trip_attr[:travel_time]).to eq("impossible route")
      expect(trip_attr).to have_key(:weather_at_eta)
      expect(trip_attr[:weather_at_eta]).to eq(nil)
    end
  end

  describe "sad path" do
    it "can return 401 if request is sent without an api_key" do
      origin = 'Boulder, CO'
      destination = 'Estes Park, CO'
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
        "destination": destination
      }

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:error)
      expect(parsed[:error]).to eq("Unable To Authenticate")
    end

    it "can return 401 if request is sent wrong an api_key" do
      origin = 'Boulder, CO'
      destination = 'Estes Park, CO'
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
        "api_key": '8fc5df71328827c3de4bdc'
      }

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:error)
      expect(parsed[:error]).to eq("Unable To Authenticate")
    end
  end
end
