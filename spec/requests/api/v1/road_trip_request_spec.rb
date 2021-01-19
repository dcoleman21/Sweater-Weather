require 'rails_helper'

describe "Road Trip API" do
  describe  "happy path" do
    it "returns road trip info in JSON format" do
      json1 = File.read('spec/fixtures/route_data_arvada_apollo_beach.json')
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Arvada,CO&key=#{ENV['MAP_QUEST_KEY']}&to=ApolloBeach,FL").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.3.0'
           }).
         to_return(status: 200, body: json1, headers: {})

      json_response = File.read('spec/fixtures/route_data_apollo_beach.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=ApolloBeach,FL").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.3.0'
          }).
        to_return(status: 200, body: json_response, headers: {})

        json2 = File.read('spec/fixtures/weather_data_apollo_beach.json')
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&lat=27.763584&lon=-82.40031&exclude=minutely,alerts&units=imperial")
          .to_return(status: 200, body: json2, headers: {})

      origin = 'Arvada,CO'
      destination = 'ApolloBeach,FL'
      api_key = SecureRandom.hex

      User.create!( email: 'dani@example.com',
                    password: '1234',
                    password_confirmation: '1234',
                    api_key: api_key
                  )

      headers = { 'CONTENT_TYPE' => 'application/json' }

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
      json_response = File.read('spec/fixtures/impossible_route.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=R2mX9Awv6x8S7AdvPLwlfEK71TXOHQHV&location=Perth,AUS").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.3.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

      origin = 'NewYork,NY'
      destination = 'Perth,AUS'
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
