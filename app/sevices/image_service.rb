class ImageService
  def get_url(url)
    response = conn.get url do |req|
    req.headers[:Authorization] = Rails.application.credentials.maps[:pexels_key]
  end
    JSON.parse(response.body, symbolize_names: true)
  end

  def image_details(location)
    get_url("/v1/search?query=#{location}&per_page=1")
  end

  def conn
    Faraday.new(url: "https://api.pexels.com")
  end
end