class Munchie
  attr_reader :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(destination_city, travel_time, forecast, restaurant)
    require "pry"; binding.pry
  end
end
