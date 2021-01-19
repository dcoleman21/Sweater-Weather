class Munchie
  attr_reader :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(destination_city, travel_time, forecast, restaurant)
    @destination_city = destination_city
    @travel_time = time_in_hours_and_mins(travel_time)
    @forecast = weather_at_arrival(forecast)
    @restaurant = restaurant_info(restaurant)
  end

  def weather_at_arrival(forecast)
    {
      summary: forecast.current_weather.conditions,
      temperature: forecast.current_weather.temperature
    }
  end

  def time_in_hours_and_mins(travel_time)
    hour = travel_time.slice(1, 1)
    minutes = travel_time.slice(3, 2)
    "#{hour} hour #{minutes} min"
  end

  def restaurant_info(restaurant)
    {
      name: restaurant[:businesses][0][:name],
      address: restaurant[:businesses][0][:location][:display_address].join(", ")
    }
  end
end
