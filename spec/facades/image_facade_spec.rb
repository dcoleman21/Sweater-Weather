require 'rails_helper'

describe ImageFacade do
  it 'can get an image object' do
    json_response = File.read('spec/fixtures/map_data_arvada.json')
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_QUEST_KEY']}&location=arvada,co")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json_response, headers: {})

    json2 = File.read('spec/fixtures/image_data_arvada.json')
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['IMAGE_KEY']}&page=1&per_page=1&query=arvada,co")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: json2, headers: {})

    location = 'arvada,co'

    image = ImageFacade.fetch_image('arvada,co')

    expect(image).to be_a(Image)
    expect(image.image).to be_a(Hash)
    expect(image.image).to have_key(:location)
    expect(image.image[:location]).to be_a(String)
    expect(image.image).to have_key(:image_url)
    expect(image.image[:image_url]).to be_a(String)
    expect(image.image).to have_key(:credit)
    expect(image.image[:credit]).to be_a(Hash)
    expect(image.image[:credit]).to have_key(:source)
    expect(image.image[:credit][:source]).to be_a(String)
    expect(image.image[:credit]).to have_key(:author)
    expect(image.image[:credit][:author]).to be_a(String)
  end
end
