require 'rails_helper'

describe "Forecast Facade" do
  it "returns the forecast for a city" do
    json_response = File.read('spec/fixtures/map_data_arvada.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=arvada,co")
    .with(
          headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.3.0'
           }
         )
         .to_return(status: 200, body: json_response, headers: {})

    json2 = File.read('spec/fixtures/weather_data_arvada.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&lat=39.801122&lon=-105.081451&units=imperial&exclude=minutely,alerts")
      .to_return(status: 200, body: json2, headers: {})


    forecast = ForecastFacade.forecast_by_coords('arvada,co')

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
