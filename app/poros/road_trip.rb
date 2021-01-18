class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, travel_time, weather_info)
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time
    @weather_at_eta = weather_at_dest(weather_info)
  end

  def weather_at_dest(weather_info)
    unless @travel_time == 'impossible route'
      {
        temperature: weather_info[:daily][1][:temp][:day],
        conditions: weather_info[:daily][1][:weather][0][:description]
      }
    end
  end
end
