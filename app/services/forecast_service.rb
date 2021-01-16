class ForecastService
  def self.forecast_by_coords(lat, lon)
    response = conn.get("/data/2.5/onecall") do |r|
      r.params['lat'] = lat
      r.params['lon'] = lon
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://api.openweathermap.org") do |f|
      f.params['units'] = 'imperial'
      f.params['appid'] = ENV['OPEN_WEATHER_KEY']
    end
  end
end
