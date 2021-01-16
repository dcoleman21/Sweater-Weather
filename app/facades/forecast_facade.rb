class ForecastFacade
  def self.forecast_by_coords(location)#"arvada,co"
    latlng = MapFacade.get_coords_by_location(location)#{:lat=>39.801122, :lng=>-105.081451}
    Forecast.new(ForecastService.forecast_by_coords(latlng[:lat], latlng[:lng]))
  end
end
