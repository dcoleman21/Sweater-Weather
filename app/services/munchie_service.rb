class MunchieService
  def self.restaurant_info(destination_city, food)
    response = conn.get("/v3/businesses/search") do |req|
      req.params['location'] = destination_city
      req.params['categories'] = "restaurants,chinese"
      req.params['term'] = food
      req.params['limit'] = 3
    end
    restaurant = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    conn = Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_KEY']}"
    end
  end
end
