class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = convert_to_date(data[:dt])
    @sunrise = convert_to_datetime(data[:sunrise]
    @sunset = convert_to_datetime(data[:sunset]
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def convert_to_date(unix_timestamp)
    Time.at(unix_timestamp).strftime('%Y-%m-%d')
  end

  def convert_to_datetime(unix_timestamp)
    Time.at(unix_timestamp)
  end
end
