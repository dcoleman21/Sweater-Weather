require 'rails_helper'

describe 'Road Trip Facade' do
  before :each do
    origin = 'Arvada,CO'
    destination = 'Apollo Beach, FL'
    api_key = SecureRandom.hex

    @user = User.create!( email: 'dani@example.com',
                  password: '1234',
                  password_confirmation: '1234',
                  api_key: api_key
                )

  end

  it 'returns a road trip poro when given an origin and destination city' do
    trip_details = RoadTripFacade.trip_info('Arvada, CO', 'Apollo Beach, FL')

    expect(trip_details).to be_a(RoadTrip)
    expect(trip_details.start_city).to eq("Arvada, CO")
    expect(trip_details.end_city).to eq("Apollo Beach, FL")
    expect(trip_details.travel_time).to be_a(String)
    expect(trip_details.weather_at_eta).to be_a(Hash)
    expect(trip_details.weather_at_eta).to have_key(:temperature)
    expect(trip_details.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(trip_details.weather_at_eta).to have_key(:conditions)
    expect(trip_details.weather_at_eta[:conditions]).to be_a(String)
  end

  it "returns a road trip poro with impossible route when origin and destination are impossible" do
    trip_details = RoadTripFacade.trip_info('New York, NY', 'Perth, AUS')

    expect(trip_details).to be_a(RoadTrip)
    expect(trip_details.start_city).to eq("New York, NY")
    expect(trip_details.end_city).to eq("Perth, AUS")
    expect(trip_details.travel_time).to be_a(String)
    expect(trip_details.travel_time).to eq("impossible route")
    expect(trip_details.weather_at_eta).to eq(nil)
  end
end
