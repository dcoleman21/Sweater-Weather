require 'rails_helper'

describe "Forecast Facade" do
  it "returns the forecast for a city" do
    forecast = ForecastFacade.forecast_by_coords('arvada, co')

    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(CurrentWeather)

    expect(forecast.daily_weather).to be_an(Array)
    forecast.daily_weather.each do |daily|
      expect(daily).to be_a(DailyWeather)
    end

    expect(forecast.hourly_weather).to be_an(Array)
    forecast.hourly_weather.each do |hourly|
      expect(hourly).to be_a(HourlyWeather)
    end
  end
end
