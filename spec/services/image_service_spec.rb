require 'rails_helper'
describe ImageService do
  it 'returns image data for location in json' do
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
