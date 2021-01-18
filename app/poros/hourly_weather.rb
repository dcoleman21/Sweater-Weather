class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = convert_to_time(data[:dt])
    @temperature = data[:temp]
    @wind_speed = "#{data[:wind_speed]} mph"
    @wind_direction = "from #{cardinal_directions(data[:wind_deg])}"
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def convert_to_time(unix_timestamp)
    Time.at(unix_timestamp).strftime('%H:%M:%S')
  end

  def cardinal_directions(degrees)
    case degrees
    when 348.75..360
      'N'
    when 0..33.74
      'N'
    when 33.75..78.74
      'NE'
    when 78.75..123.74
      'E'
    when 123.75..168.74
      'SE'
    when 168.75..213.74
      'S'
    when 213.75..258.74
      'SW'
    when 258.75..303.74
      'W'
    when 303.75..348.74
      'NW'
    end
  end
end
