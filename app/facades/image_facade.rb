class ImageFacade
  def self.fetch_image(location)
    image_info = ImageService.fetch_image_info(location)
    Image.new(image_info[:results], location)
  end
end
