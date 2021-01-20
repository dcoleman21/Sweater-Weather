require 'rails_helper'

describe  'Background Image API' do
  it 'can fetch a background image for that page showing the city' do
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

    get '/api/v1/backgrounds?location=arvada,co'

    expect(response).to be_successful
    image = JSON.parse(response.body, symbolize_names: true)

    expect(image).to be_a(Hash)
    expect(image).to have_key(:data)
    expect(image[:data]).to be_a(Hash)
    expect(image[:data]).to have_key(:type)
    expect(image[:data][:type]).to eq('image')
    expect(image[:data]).to have_key(:id)
    expect(image[:data][:id]).to eq(nil)
    expect(image[:data]).to have_key(:attributes)
    expect(image[:data][:attributes]).to be_a(Hash)
    expect(image[:data][:attributes]).to have_key(:image)
    expect(image[:data][:attributes][:image]).to be_a(Hash)
    expect(image[:data][:attributes][:image]).to have_key(:location)
    expect(image[:data][:attributes][:image][:location]).to be_a(String)
    expect(image[:data][:attributes][:image]).to have_key(:image_url)
    expect(image[:data][:attributes][:image][:image_url]).to be_a(String)
    expect(image[:data][:attributes][:image]).to have_key(:credit)
    expect(image[:data][:attributes][:image][:credit]).to be_a(Hash)
    expect(image[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(image[:data][:attributes][:image][:credit][:source]).to be_a(String)
    expect(image[:data][:attributes][:image][:credit]).to have_key(:author)
    expect(image[:data][:attributes][:image][:credit][:author]).to be_a(String)
  end
end
