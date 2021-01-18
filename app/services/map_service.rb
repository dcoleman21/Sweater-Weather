class MapService
  def self.get_coords_by_location(location)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['location'] = location
      req.params['key'] = ENV['MAP_QUEST_KEY']
    end
    parsed = JSON.parse(response.body, symbolize_names: true)
    parse_lat_lng(parsed)
  end

  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com", headers: { 'Content-Type' => 'application/json' })
  end

  def self.parse_lat_lng(response)
    if response[:results][0][:locations].empty?
      {lat: 'no match', lng: 'no match'}
    else
      response[:results][0][:locations][0][:latLng]
    end
  end
end
