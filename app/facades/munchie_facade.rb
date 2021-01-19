class MunchieFacade
  def self.fetch_restaurant_info(location)
    start_city = location[:start]
    destination_city = location[:end]
    food = location[:food]
    restaurant = MunchieService.restaurant_info(destination_city, food)
    travel_time = MapFacade.time_between_locations(start_city, destination_city)
    forecast = ForecastFacade.forecast_by_coords(destination_city)
    Munchie.new(destination_city, travel_time, forecast, restaurant)
  end
end
