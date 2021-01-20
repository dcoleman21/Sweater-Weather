require 'rails_helper'

describe 'Current Weather Poro' do
  it 'can create a current weather object' do
    raw_data = File.read('spec/fixtures/weather_data_arvada.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    current = parsed_data[:current]

    current_weather = CurrentWeather.new(current)
    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to be_a(Time)
    expect(current_weather.sunrise).to be_a(Time)
    expect(current_weather.sunset).to be_a(Time)
    expect(current_weather.temperature).to be_a(Numeric)
    expect(current_weather.feels_like).to be_a(Numeric)
    expect(current_weather.humidity).to be_a(Numeric)
    expect(current_weather.uvi).to be_a(Numeric)
    expect(current_weather.visibility).to be_a(Numeric)
    expect(current_weather.conditions).to be_a(String)
    expect(current_weather.icon).to be_a(String)
  end
end
