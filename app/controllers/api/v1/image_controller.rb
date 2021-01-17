class Api::V1::ImageController < ApplicationController
  def show
    image = ImageFacade.fetch_image(params[:location])
    render json: ImageSerializer.new(image)
  end
end
