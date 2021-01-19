require 'rails_helper'

describe ForecastService do
  describe "happy paths" do
    it "can get the forecast for with lat and lon" do
      json2 = File.read('spec/fixtures/weather_data_arvada.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&lat=39.801122&lon=-105.081451&units=imperial&exclude=minutely,alerts")
        .to_return(status: 200, body: json2, headers: {})

      forecast_info = ForecastService.forecast_by_coords(39.801122, -105.081451)

      expect(forecast_info).to be_a(Hash)
      expect(forecast_info).to have_key(:lat)
      expect(forecast_info[:lat]).to be_a(Float)
      expect(forecast_info).to have_key(:lon)
      expect(forecast_info[:lon]).to be_a(Float)
      expect(forecast_info).to have_key(:current)
      expect(forecast_info[:current]).to be_a(Hash)
      expect(forecast_info).to have_key(:daily)
      expect(forecast_info[:daily]).to be_an(Array)
      expect(forecast_info).to have_key(:hourly)
      expect(forecast_info[:hourly]).to be_an(Array)
    end
  end
end
