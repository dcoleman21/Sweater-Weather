require 'rails_helper'

describe MapService do
  describe 'happy paths' do
    it "can get the get the lat and lon for a location" do
      response = MapService.get_coords_by_location('arvada, co')

      expect(response).to be_a(Hash)
      expect(response).to have_key(:lat)
      expect(response[:lat]).to be_a(Float)
      expect(response).to have_key(:lng)
      expect(response[:lng]).to be_a(Float)
    end
  end
end
