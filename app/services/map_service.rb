class MapService
  def self.get_coords_by_location(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['location'] = location
      req.params['key'] = ENV['MAP_QUEST_KEY']
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    parse_lat_lng(parsed)
  end

  def self.parse_lat_lng(response)
    if response[:results][0][:locations].empty?
      {lat: 'no match', lng: 'no match'}
    else
      response[:results][0][:locations][0][:latLng]
    end
  end

  def self.route(origin, destination)
    response = conn.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['MAP_QUEST_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com")
  end

end
