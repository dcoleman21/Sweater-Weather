require 'rails_helper'

describe DailyWeather do
  it "can create a list of daily weather objects" do
    raw_data = File.read('spec/fixtures/weather_data_arvada.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    daily = parsed_data[:daily][0..4].first
    daily_weather = DailyWeather.new(daily)
    
    expect(daily_weather).to be_a(DailyWeather)
    expect(daily_weather.date).to be_a(String)
    expect(daily_weather.sunrise).to be_a(Time)
    expect(daily_weather.sunset).to be_a(Time)
    expect(daily_weather.max_temp).to be_a(Numeric)
    expect(daily_weather.min_temp).to be_a(Numeric)
    expect(daily_weather.conditions).to be_a(String)
    expect(daily_weather.icon).to be_a(String)
  end
end
