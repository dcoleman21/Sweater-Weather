require 'rails_helper'

describe 'Road Trip Poro' do
  it "can create road trip objects" do
    origin = 'Arvada,CO'
    destination = 'Apollo Beach, FL'
    api_key = SecureRandom.hex

    user = User.create!( email: 'betty@example.com',
                  password: '1234',
                  password_confirmation: '1234',
                  api_key: api_key
                )


    travel_time = '27:13:01'


    raw_data = File.read('spec/fixtures/weather_data_apollo_beach.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    weather = parsed_data
    road_trip = RoadTrip.new(origin, destination, travel_time, weather)

    expect(road_trip).to be_a(RoadTrip)
    expect(road_trip.start_city).to be_a(String)
    expect(road_trip.start_city).to eq("Arvada,CO")
    expect(road_trip.end_city).to be_a(String)
    expect(road_trip.end_city).to eq("Apollo Beach, FL")
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.travel_time).to eq("27:13:01")
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(road_trip.weather_at_eta[:temperature]).to eq(61.11)
    expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    expect(road_trip.weather_at_eta[:conditions]).to eq("clear sky")
  end

end
