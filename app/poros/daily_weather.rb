class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = convert_to_date(data[0][:dt])
    @sunrise = convert_to_datetime(data[0][:sunrise])
    @sunset = convert_to_datetime(data[0][:sunset])
    @max_temp = data[0][:temp][:max]
    @min_temp = data[0][:temp][:min]
    @conditions = data[0][:weather][0][:description]
    @icon = data[0][:weather][0][:icon]
  end

  def convert_to_date(unix_timestamp)
    Time.at(unix_timestamp).strftime('%Y-%m-%d')
  end

  def convert_to_datetime(unix_timestamp)
    Time.at(unix_timestamp)
  end
end
