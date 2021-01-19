class Api::V1::MunchiesController < ApplicationController
  def index
    start = params[:start]
    dest = params[:end]
    food = params[:food]

    conn = Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
      # f.params['location'] = dest
      # f.params['categories'] = "restaurants,chinese"
      # f.params['term'] = food
      # f.params['limit'] = 3
    end
    response = conn.get("/v3/businesses/search") do |req|
      req.params['location'] = dest
      req.params['categories'] = "restaurants,chinese"
      req.params['term'] = food
      req.params['limit'] = 3
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    @munchies = fetch_restaurant_data(parsed)
  end

  def fetch_restaurant_data(parsed)
    parsed[:businesses].map do |data|
      require "pry"; binding.pry
      Munchie.new(data)
    end
  end
end
