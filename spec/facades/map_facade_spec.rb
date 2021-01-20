require 'rails_helper'

describe "Map Facade" do
  it "returns the lat and lon for a city" do
    json_response = File.read('spec/fixtures/map_data_arvada.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=arvada,co").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.3.0'
        }).
      to_return(status: 200, body: json_response, headers: {})

    location = MapFacade.get_coords_by_location('arvada,co')

    expect(location).to be_a(Hash)

    expect(location).to have_key(:lat)
    expect(location[:lat]).to be_a(Float)
    expect(location).to have_key(:lng)
    expect(location[:lng]).to be_a(Float)
  end
end
