class Image
  attr_reader :image

  def initialize(data, location)
    @image = image_hash(data, location)
  end

  def image_hash(data, location)
    {
      location: location,
      image_url: data[0][:urls][:regular],
      credit: credit_hash(data)
    }
  end

  def credit_hash(data)
    {
      source: data[0][:links][:self],
      author: data[0][:user][:name]
    }
  end
end
