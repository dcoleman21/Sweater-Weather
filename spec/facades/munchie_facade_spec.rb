require 'rails_helper'

describe  MunchieFacade do
  it "returns a restaurant based on food type and location" do
    start_city = 'denver,co'
    destination_city = 'pueblo,co'
    food = 'chinese'

    result = MunchieFacade.fetch_restaurant_info(start_city, destination_city, food)

    expect(result).to be_a(Munchie)
  end
end
