class ForecastService
  def self.forecast_by_coords(lat, lon)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lat
      req.params['lon'] = lon
      req.params['exclude'] = 'minutely,alerts'
      req.params['appid'] = ENV['OPEN_WEATHER_KEY']
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org/data/2.5/onecall?', headers: { 'Content-type' => 'application/json' })
  end
end
