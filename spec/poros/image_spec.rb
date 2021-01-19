require 'rails_helper'

describe Image do
  it "can create an image object" do
    location = 'arvada,co'
    raw_data = File.read('spec/fixtures/image_data_arvada.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    image_array = parsed_data[:results]

    image = Image.new(image_array, location)

    expect(image).to be_a(Image)
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
