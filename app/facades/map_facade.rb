class MapFacade
  def self.get_coords_by_location(location)
    MapService.get_coords_by_location(location)
  end

  def self.time_between_locations(origin, destination)
    route_info = MapService.route(origin, destination)
    if route_info[:info][:statuscode] == 402
      'impossible route'
    else
      route_info[:route][:formattedTime]
    end
  end
end
