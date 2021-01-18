class RoadTripFacade
  def self.trip_info(origin, destination)
    travel_time = MapFacade.time_between_locations(origin, destination)
    coords = MapFacade.get_coords_by_location(destination)
    weather_info = WeatherFacade.hourly_forecast(coords.latitude, coords.longitude)
    require "pry"; binding.pry
    # weather = weather_info[travel_time.second]
    # RoadTrip.new(origin, destination, travel_time.first, weather)
  end
end
