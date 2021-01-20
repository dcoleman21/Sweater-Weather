require 'rails_helper'

describe " Forecast API" do
  describe 'Retreive weather for a city'
    it "returns the weather forecast for a specific location" do
      json_response = File.read('spec/fixtures/map_data_arvada.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=arvada,co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.3.0'
          }).
        to_return(status: 200, body: json_response, headers: {})

      json2 = File.read('spec/fixtures/weather_data_arvada.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OPEN_WEATHER_KEY']}&lat=39.801122&lon=-105.081451&units=imperial&exclude=minutely,alerts")
        .to_return(status: 200, body: json2, headers: {})

      get '/api/v1/forecast?location=arvada,co'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a(Hash)

      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data]).to have_key(:id)
      expect(forecast[:data][:id]).to be_nil
      expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq('forecast')
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to be_a(Hash)

      current_forecast = forecast[:data][:attributes][:current_weather]
      expect(current_forecast).to be_a(Hash)
      expect(current_forecast).to have_key(:datetime)
      expect(current_forecast[:datetime]).to be_a(String)
      expect(current_forecast).to have_key(:sunrise)
      expect(current_forecast[:sunrise]).to be_a(String)
      expect(current_forecast).to have_key(:sunset)
      expect(current_forecast[:sunset]).to be_a(String)
      expect(current_forecast).to have_key(:temperature)
      expect(current_forecast[:temperature]).to be_a(Numeric)
      expect(current_forecast).to have_key(:feels_like)
      expect(current_forecast[:feels_like]).to be_a(Numeric)
      expect(current_forecast).to have_key(:humidity)
      expect(current_forecast[:humidity]).to be_a(Numeric)
      expect(current_forecast).to have_key(:uvi)
      expect(current_forecast[:uvi]).to be_a(Numeric)
      expect(current_forecast).to have_key(:conditions)
      expect(current_forecast[:conditions]).to be_a(String)
      expect(current_forecast).to have_key(:icon)
      expect(current_forecast[:icon]).to be_a(String)
      # DOESN'T RETURN TOO MUCH INFO FROM JSON
      expect(current_forecast).to_not have_key(:clouds)
      expect(current_forecast).to_not have_key(:pressure)
      # TESTING LIVE DATA FROM POSTMAN
      # expect(current_forecast[:temperature]).to eq(35.94)
      # expect(current_forecast[:feels_like]).to eq(26.17)
      # expect(current_forecast[:humidity]).to eq(51)
      # expect(current_forecast[:uvi]).to eq(0)
      # expect(current_forecast[:conditions]).to eq('scattered clouds')
      # expect(current_forecast[:icon]).to eq('03n')

      daily_forecast = forecast[:data][:attributes][:daily_weather]
      expect(daily_forecast).to be_a(Array)
      expect(daily_forecast.count).to eq(5)
      expect(daily_forecast.first).to have_key(:date)
      expect(daily_forecast.first[:date]).to be_a(String)
      expect(daily_forecast.first).to have_key(:sunrise)
      expect(daily_forecast.first[:sunrise]).to be_a(String)
      expect(daily_forecast.first).to have_key(:sunset)
      expect(daily_forecast.first[:sunset]).to be_a(String)
      expect(daily_forecast.first).to have_key(:max_temp)
      expect(daily_forecast.first[:max_temp]).to be_a(Numeric)
      expect(daily_forecast.first).to have_key(:min_temp)
      expect(daily_forecast.first[:min_temp]).to be_a(Numeric)
      expect(daily_forecast.first).to have_key(:conditions)
      expect(daily_forecast.first[:conditions]).to be_a(String)
      expect(daily_forecast.first).to have_key(:icon)
      expect(daily_forecast.first[:icon]).to be_a(String)
      # DOESN'T RETURN TOO MUCH INFO FROM JSON
      expect(current_forecast).to_not have_key(:clouds)
      expect(current_forecast).to_not have_key(:pressure)
      # TESTING LIVE DATA FROM POSTMAN
      # expect(daily_forecast.first[:max_temp]).to eq(44.22)
      # expect(daily_forecast.first[:min_temp]).to eq(34.23)
      # expect(daily_forecast.first[:conditions]).to eq('clear sky')
      # expect(daily_forecast.first[:icon]).to eq('01d')

      hourly_forecast = forecast[:data][:attributes][:hourly_weather]
      expect(hourly_forecast).to be_a(Array)
      expect(hourly_forecast.count).to eq(8)
      expect(hourly_forecast.first).to have_key(:time)
      expect(hourly_forecast.first[:time]).to be_a(String)
      expect(hourly_forecast.first).to have_key(:temperature)
      expect(hourly_forecast.first[:temperature]).to be_a(Numeric)
      expect(hourly_forecast.first).to have_key(:wind_speed)
      expect(hourly_forecast.first[:wind_speed]).to be_a(String)
      expect(hourly_forecast.first).to have_key(:wind_direction)
      expect(hourly_forecast.first[:wind_direction]).to be_a(String)
      expect(hourly_forecast.first).to have_key(:conditions)
      expect(hourly_forecast.first[:conditions]).to be_a(String)
      expect(hourly_forecast.first).to have_key(:icon)
      expect(hourly_forecast.first[:icon]).to be_a(String)
      # DOESN'T RETURN TOO MUCH INFO FROM JSON
      expect(current_forecast).to_not have_key(:clouds)
      expect(current_forecast).to_not have_key(:pressure)
      # TESTING LIVE DATA FROM POSTMAN
      # expect(hourly_forecast.first[:temperature]).to eq(36.36)
      # expect(hourly_forecast.first[:wind_speed]).to eq('3.85 mph')
      # expect(hourly_forecast.first[:wind_direction]).to eq('from S')
      # expect(hourly_forecast.first[:conditions]).to eq('scattered clouds')
      # expect(hourly_forecast.first[:icon]).to eq('04n')
    end
end
