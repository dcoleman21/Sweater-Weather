class ForecastFacade
  def self.forecast_by_coords(location)
    latlng = MapFacade.get_coords_by_location(location)
    weather_payload = ForecastService.forecast_by_coords(latlng[:lat], latlng[:lng])
    current = CurrentWeather.new(weather_payload[:current])
    daily = daily_forecast(weather_payload[:daily][0..4])
    hourly = hourly_forecast(weather_payload[:hourly][0..7])
    Forecast.new(current, daily, hourly)
  end

  def self.daily_forecast(weather_payload)
    weather_payload.map do |data|
      DailyWeather.new(data)
    end
  end

  def self.hourly_forecast(weather_payload)
    weather_payload.map do |data|
      HourlyWeather.new(data)
    end
  end
end
