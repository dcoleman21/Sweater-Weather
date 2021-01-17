require 'rails_helper'
describe ImageService do
  it "returns image data for location in json" do
    location = 'arvada,co'

    result = ImageService.fetch_image_info(location)
    expect(result).to be_a(Hash)
    expect(result).to have_key(:results)

    image_info = result[:results]
    
    expect(image_info).to be_an(Array)
    expect(image_info[0]).to have_key(:urls)
    expect(image_info[0][:urls]).to be_a(Hash)
    expect(image_info[0][:urls]).to have_key(:regular)
    expect(image_info[0][:urls][:regular]).to be_a(String)
    expect(image_info[0]).to have_key(:links)
    expect(image_info[0][:links]).to be_a(Hash)
    expect(image_info[0][:links]).to have_key(:self)
    expect(image_info[0][:links][:self]).to be_a(String)
    expect(image_info[0]).to have_key(:user)
    expect(image_info[0][:user]).to be_a(Hash)
    expect(image_info[0][:user]).to have_key(:name)
    expect(image_info[0][:user][:name]).to be_a(String)
  end
end
