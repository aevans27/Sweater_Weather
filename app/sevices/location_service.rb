class LocationService
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def location_details(location)
    get_url("/geocoding/v1/address?inFormat=kvp&outFormat=json&location=#{location}")
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
     faraday.params['key'] = Rails.application.credentials.maps[:mapquest_key]
    end
  end
end