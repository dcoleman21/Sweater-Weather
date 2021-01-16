class ForecastFacade
  def self.forecast_by_coords(location)
    latlng = MapFacade.get_coords_by_location(location)
    Forecast.new(latlng)
  end
end
