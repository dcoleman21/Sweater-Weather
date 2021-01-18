class RoadTripFacade
  def self.trip_info(origin, destination)
    travel_time = MapFacade.time_between_locations(origin, destination)
    coords = MapFacade.get_coords_by_location(destination)
    weather_info = ForecastService.forecast_by_coords(coords[:lat], coords[:lng])
    RoadTrip.new(origin, destination, travel_time, weather_info)
  end
end
