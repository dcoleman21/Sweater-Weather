class ForecastFacade
  def self.forecast_by_coords(location)
    latlng = MapService.get_coords_by_location(location)
    Forecast.new(ForecastService.forecast_by_coords(latlng[:lat], latlng[:lng]))
  end
end
