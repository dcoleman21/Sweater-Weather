require 'rails_helper'

describe ForecastService do
  describe "happy paths" do
    it "can get the forecast for with lat and lon" do
      response = ForecastService.forecast_by_coords(39.801122, -105.081451)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:lat)
      expect(response[:lat]).to be_a(Float)
      expect(response).to have_key(:lon)
      expect(response[:lon]).to be_a(Float)
      expect(response).to have_key(:current)
      expect(response[:current]).to be_a(Hash)
      expect(response).to have_key(:daily)
      expect(response[:daily]).to be_an(Array)
      expect(response).to have_key(:hourly)
      expect(response[:hourly]).to be_an(Array)
    end
  end
end
