class MapFacade
  def self.get_coords_by_location(location)
    MapService.get_coords_by_location(location)
  end

  def self.time_between_locations(origin, destination)
    result = MapService.route(origin, destination)
    if result[:info][:statuscode] == 402
      'impossible route'
    else
      result[:route][:formattedTime]
    end
  end
end
