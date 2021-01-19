class Api::V1::MunchiesController < ApplicationController
  def index
    # start_city = params[:start]
    # destination_city = params[:end]
    # food = params[:food]
    #
    # conn = Faraday.new(url: "https://api.yelp.com") do |faraday|
    #   faraday.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
    # end
    # response = conn.get("/v3/businesses/search") do |req|
    #   req.params['location'] = destination_city
    #   req.params['categories'] = "restaurants,chinese"
    #   req.params['term'] = food
    #   req.params['limit'] = 3
    # end
    # restaurant = JSON.parse(response.body, symbolize_names: true)
    # travel_time = MapFacade.time_between_locations(start_city, destination_city)
    # forecast = ForecastFacade.forecast_by_coords(destination_city)
    # munchies = Munchie.new(destination_city, travel_time, forecast, restaurant)
    munchie = MunchieFacade.fetch_restaurant_info(munchie_params)
    render json: MunchieSerializer.new(munchie)
  end

  private
  
  def munchie_params
    params.permit(:start, :end, :food)
  end
end
