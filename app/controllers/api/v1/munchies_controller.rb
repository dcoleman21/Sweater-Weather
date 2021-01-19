class Api::V1::MunchiesController < ApplicationController
  def index
    start_city = params[:start]
    destination_city = params[:end]
    food = params[:food]

    conn = Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
      # f.params['location'] = dest
      # f.params['categories'] = "restaurants,chinese"
      # f.params['term'] = food
      # f.params['limit'] = 3
    end
    response = conn.get("/v3/businesses/search") do |req|
      req.params['location'] = destination_city
      req.params['categories'] = "restaurants,chinese"
      req.params['term'] = food
      req.params['limit'] = 3
    end
    restaurant = JSON.parse(response.body, symbolize_names: true)
    travel_time = MapFacade.time_between_locations(start_city, destination_city)
    forecast = ForecastFacade.forecast_by_coords(destination_city)
    munchies = Munchie.new(destination_city, travel_time, forecast, restaurant)
    render json: MunchieSerializer.new(munchies)
  end

  # def fetch_restaurant_data(restaurant)
  #   restaurant[:businesses].map do |data|
  #     Munchie.new(data)
  #   end
  # end
end
