require 'rails_helper'

describe "Current Weather Poro" do
  it "exists" do
    latlng = MapService.get_coords_by_location('arvada, co')
    forecast = ForecastService.forecast_by_coords(latlng[:lat], latlng[:lng])
    current_weather = CurrentWeather.new(forecast[:current])

    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to be_a(Time)
    expect(currrent_weather.sunrise).to be_a(Time)
    expect(currrent_weather.sunset).to be_a(Time)
    expect(currrent_weather.temperature).to be_a(Numeric)
    expect(currrent_weather.feels_like).to be_a(Numeric)
    expect(currrent_weather.humidity).to be_a(Numeric)
    expect(currrent_weather.uvi).to be_a(Numeric)
    expect(currrent_weather.visibility).to be_a(Numeric)
    expect(currrent_weather.conditions).to be_a(String)
    expect(currrent_weather.icon).to be_a(String)
  end
end