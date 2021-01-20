require 'rails_helper'

describe 'Road Trip Facade' do
  before :each do
    User.create!(email: 'dani@email.com',
                 password: 'loveme',
                 password_confirmation: 'loveme',
                 api_key: SecureRandom.hex)
  end

  it 'returns a road trip poro when given an origin and destination city' do
    json1 = File.read('spec/fixtures/route_data_arvada_apollo_beach.json')
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Arvada,CO&key=#{ENV['MAP_QUEST_KEY']}&to=ApolloBeach,FL")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json1, headers: {})

    json_response = File.read('spec/fixtures/map_data_apollo_beach.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=ApolloBeach,FL")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json_response, headers: {})

    json2 = File.read('spec/fixtures/weather_data_apollo_beach.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&lat=27.763584&lon=-82.40031&exclude=minutely,alerts&units=imperial")
      .to_return(status: 200, body: json2, headers: {})

    trip_details = RoadTripFacade.trip_info('Arvada,CO', 'ApolloBeach,FL')

    expect(trip_details).to be_a(RoadTrip)
    expect(trip_details.start_city).to eq('Arvada,CO')
    expect(trip_details.end_city).to eq('ApolloBeach,FL')
    expect(trip_details.travel_time).to be_a(String)
    expect(trip_details.weather_at_eta).to be_a(Hash)
    expect(trip_details.weather_at_eta).to have_key(:temperature)
    expect(trip_details.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(trip_details.weather_at_eta).to have_key(:conditions)
    expect(trip_details.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'returns a road trip poro with impossible route when origin and destination are impossible' do

    json_response = File.read('spec/fixtures/impossible_route.json')
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=NewYork,NY&key=#{ENV['MAP_QUEST_KEY']}&to=Perth,AUS")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json_response, headers: {})
    json1 = File.read('spec/fixtures/impossible_route.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=Perth,AUS")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json1, headers: {})

    trip_details = RoadTripFacade.trip_info('NewYork,NY', 'Perth,AUS')

    expect(trip_details).to be_a(RoadTrip)
    expect(trip_details.start_city).to eq('NewYork,NY')
    expect(trip_details.end_city).to eq('Perth,AUS')
    expect(trip_details.travel_time).to be_a(String)
    expect(trip_details.travel_time).to eq('impossible route')
    expect(trip_details.weather_at_eta).to eq(nil)
  end
end
