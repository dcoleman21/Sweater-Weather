require 'rails_helper'

describe "Map Facade" do
  it "returns the lat and lon for a city" do
    location = MapFacade.get_coords_by_location('arvada, co')
    
    expect(location).to be_a(Hash)

    expect(location).to have_key(:lat)
    expect(location[:lat]).to be_a(Float)
    expect(location).to have_key(:lng)
    expect(location[:lng]).to be_a(Float)
  end
end
