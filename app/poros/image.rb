class Image
  attr_reader :id, :type, :image
  def initialize(data, location)
    @id = data[:nothing]
    @type = "image"
    @image = {
      :location => location,
      :image_url => data[:photos].first[:url],
      :credit => {
        :source => "pexels.com",
        :author => data[:photos].first[:photographer],
        :logo => "https://images.pexels.com/lib/api/pexels-white.png"
      }
    }
  end
end