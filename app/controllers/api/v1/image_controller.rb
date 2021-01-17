class Api::V1::ImageController < ApplicationController
  def show
    location = params[:location]

    conn = Faraday.new(url: "https://api.unsplash.com") do |f|
      f.params['query'] = location
      f.params['page'] = 1
      f.params['per_page'] = 1
      f.params['client_id'] = ENV['IMAGE_KEY']
    end
    response = conn.get('/search/photos')
    json = JSON.parse(response.body, symbolize_names: true)

    @image = fetch_image_data(json, location)
    render json: ImageSerializer.new(@image)
  end

  def fetch_image_data(json, location)
    Image.new(json[:results], location)
  end
end
