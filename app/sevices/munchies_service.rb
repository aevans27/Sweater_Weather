class MunchiesService
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def munchies_details(destination, food)
    get_url("/v3/businesses/search?location=#{destination}&term=#{food}")
  end

  def conn
    Faraday.new(url: "https://api.yelp.com") do |faraday|
     faraday.headers["Authorization"] = "Bearer #{Rails.application.credentials.maps[:yelp_key]}"
    end
  end
end