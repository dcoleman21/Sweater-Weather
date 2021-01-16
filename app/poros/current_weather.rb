class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = convert_to_datetime(data[:dt])
    @sunrise = convert_to_datetime(data[:sunrise])
    @sunset = convert_to_datetime(data[:sunset])
    @temperature = data[:temp]
    @feel_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:details][0][:description]
    @icon = data[:details][0][:icon]
  end

  def convert_to_datetime(unix_timestamp)
    Time.at(unix_timestamp)
  end
end
