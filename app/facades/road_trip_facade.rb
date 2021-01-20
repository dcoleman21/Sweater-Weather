class RoadTripFacade
  def self.trip_info(origin, destination)
    travel_time = MapFacade.time_between_locations(origin, destination)
    weather_info = ''
    if travel_time != 'impossible route'
      coords = MapFacade.get_coords_by_location(destination)
      weather_info = ForecastService.forecast_by_coords(coords[:lat], coords[:lng])
    end
    RoadTrip.new(origin, destination, travel_time, weather_info)
  end
end
