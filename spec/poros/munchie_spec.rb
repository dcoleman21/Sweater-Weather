require 'rails_helper'

describe 'Munchie Poro' do
  it "can create munchie objects" do
    start_city = 'denver,co'
    destination_city = 'pueblo,co'
    food = 'chinese'

    result = MunchieFacade.fetch_restaurant_info(start_city, destination_city, food)

    expect(result).to be_a(Munchie)
    expect(result.destination_city).to be_a(String)
    expect(result.travel_time).to be_a(String)
    expect(result.forecast).to be_a(Hash)
    expect(result.forecast).to have_key(:summary)
    expect(result.forecast[:summary]).to be_a(String)
    expect(result.forecast).to have_key(:temperature)
    expect(result.forecast[:temperature]).to be_a(Numeric)
    expect(result.restaurant).to be_a(Hash)
    expect(result.restaurant).to have_key(:name)
    expect(result.restaurant[:name]).to be_a(String)
    expect(result.restaurant).to have_key(:address)
    expect(result.restaurant[:address]).to be_a(String)
  end
end
