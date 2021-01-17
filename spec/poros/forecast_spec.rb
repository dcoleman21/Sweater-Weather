require 'rails_helper'

describe 'Forecast Poro' do
  it "exists" do
    current = {
      "data": {
          "id": nil,
          "type": "forecast",
          "attributes": {
              "current_weather": {
                  "datetime": "2021-01-16T17:58:28.000-07:00",
                  "sunrise": "2021-01-16T07:19:06.000-07:00",
                  "sunset": "2021-01-16T17:00:54.000-07:00",
                  "temperature": 36.34,
                  "feel_like": 26.15,
                  "humidity": 51,
                  "uvi": 0,
                  "visibility": 10000,
                  "conditions": "scattered clouds",
                  "icon": "03n"
              }
            }
          }
        }

    daily = {
      "daily_weather": [
          {
              "date": "2021-01-16",
              "sunrise": "2021-01-16T07:19:06.000-07:00",
              "sunset": "2021-01-16T17:00:54.000-07:00",
              "max_temp": 44.69,
              "min_temp": 34.18,
              "conditions": "clear sky",
              "icon": "01d"
          },
          {
              "date": "2021-01-17",
              "sunrise": "2021-01-17T07:18:40.000-07:00",
              "sunset": "2021-01-17T17:02:01.000-07:00",
              "max_temp": 45.48,
              "min_temp": 31.89,
              "conditions": "overcast clouds",
              "icon": "04d"
          },
          {
              "date": "2021-01-18",
              "sunrise": "2021-01-18T07:18:11.000-07:00",
              "sunset": "2021-01-18T17:03:09.000-07:00",
              "max_temp": 36.99,
              "min_temp": 28,
              "conditions": "snow",
              "icon": "13d"
          },
          {
              "date": "2021-01-19",
              "sunrise": "2021-01-19T07:17:40.000-07:00",
              "sunset": "2021-01-19T17:04:17.000-07:00",
              "max_temp": 31.86,
              "min_temp": 25.56,
              "conditions": "light snow",
              "icon": "13d"
          },
          {
              "date": "2021-01-20",
              "sunrise": "2021-01-20T07:17:07.000-07:00",
              "sunset": "2021-01-20T17:05:26.000-07:00",
              "max_temp": 47.44,
              "min_temp": 30.54,
              "conditions": "clear sky",
              "icon": "01d"
          }
        ]
      }

    hourly = {
      "hourly_weather": [
          {
              "time": "17:00:00",
              "temperature": 36.34,
              "wind_speed": "3.85 mph",
              "wind_direction": "from S",
              "conditions": "scattered clouds",
              "icon": "03d"
          },
          {
              "time": "18:00:00",
              "temperature": 37.53,
              "wind_speed": "3.11 mph",
              "wind_direction": "from S",
              "conditions": "broken clouds",
              "icon": "04n"
          },
          {
              "time": "19:00:00",
              "temperature": 37.2,
              "wind_speed": "2.42 mph",
              "wind_direction": "from S",
              "conditions": "overcast clouds",
              "icon": "04n"
          },
          {
              "time": "20:00:00",
              "temperature": 36.16,
              "wind_speed": "3.29 mph",
              "wind_direction": "from SE",
              "conditions": "overcast clouds",
              "icon": "04n"
          },
          {
              "time": "21:00:00",
              "temperature": 35.2,
              "wind_speed": "4.05 mph",
              "wind_direction": "from SE",
              "conditions": "overcast clouds",
              "icon": "04n"
          },
          {
              "time": "22:00:00",
              "temperature": 34.66,
              "wind_speed": "2.77 mph",
              "wind_direction": "from S",
              "conditions": "overcast clouds",
              "icon": "04n"
          },
          {
              "time": "23:00:00",
              "temperature": 34.18,
              "wind_speed": "2.73 mph",
              "wind_direction": "from SE",
              "conditions": "overcast clouds",
              "icon": "04n"
          },
          {
              "time": "00:00:00",
              "temperature": 33.06,
              "wind_speed": "6.02 mph",
              "wind_direction": "from E",
              "conditions": "overcast clouds",
              "icon": "04n"
          }
        ]
      }

    forecast = Forecast.new(current, daily, hourly)

    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(Hash)

    forecast.daily_weather.each do |daily|
      expect(daily).to be_an(Array)
    end

    forecast.hourly_weather.each do |hourly|
      expect(hourly).to be_an(Array)
    end
  end
end
