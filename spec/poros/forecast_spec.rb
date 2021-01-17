require 'rails_helper'

describe 'Forecast Poro' do
  it "can create forecast objecst" do
    raw_data = File.read('spec/fixtures/weather_data_arvada.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)

    current = parsed_data[:current]
    daily = parsed_data[:daily][0..4].first
    hourly = parsed_data[:hourly][0..7].first

    current_weather = CurrentWeather.new(current)
    daily_weather = DailyWeather.new(daily)
    hourly_weather = HourlyWeather.new(hourly)

    forecast = Forecast.new(current_weather, daily_weather, hourly_weather)

    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(CurrentWeather)
    expect(forecast.daily_weather).to be_a(DailyWeather)
    expect(forecast.hourly_weather).to be_a(HourlyWeather)
  end
end
