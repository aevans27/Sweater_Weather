class ImageFacade
  def image_details(location)
    service = ImageService.new
    Image.new(service.image_details(location), location)
  end
end