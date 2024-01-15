class RoadTripService
  def get_url(url, start, finish)
    response = conn.post url do |req|
    req.headers[:content_type] = 'application/json'
    req.body = JSON.generate("locations": [ "#{start}", "#{finish}"])
  end
    JSON.parse(response.body, symbolize_names: true)
  end

  def trip_details(start, finish)
    get_url("/directions/v2/route", start, finish)
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
     faraday.params['key'] = Rails.application.credentials.maps[:mapquest_key]
    end
  end
end