class ForecastService
  def self.forecast_by_coords(lat, lon)
    response = conn.get("/data/2.5/onecall") do |request|
      request.params['appid'] = ENV['OPEN_WEATHER_KEY']
      request.params['lat'] = lat
      request.params['lon'] = lon
      request.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
    #returns entire payload from openweather api
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org/data/2.5/onecall?')
  end
end
