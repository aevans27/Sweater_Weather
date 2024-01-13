class Location
  attr_reader :lat, :lng
  def initialize(data)
    @lat = data[:results].first[:locations].first[:latLng][:lat]
    @lng = data[:results].first[:locations].first[:latLng][:lng]
  end
end