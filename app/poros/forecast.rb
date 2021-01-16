class Forecast
  attr_reader :current_weather
              :daily_weather
              :hourly_weather

  def initialize(data)# {:lat=>39.801122, :lng=>-105.081451}
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = DailyWeather.new(data[:daily])
    @hourly_weather = HourlyWeather.new(data[:hourly])
  end
end
