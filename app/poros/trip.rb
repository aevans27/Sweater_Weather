class Trip
  attr_reader :id, :type, :start_city, :end_city, :lat, :lng, :travel_time, :weather_at_eta
  def initialize(data, start, finish)
    @id = data[:nothing]
    @type = "roadtrip"
    @start_city = start
    @end_city = finish
    if data[:route][:legs].present?
      @lat = data[:route][:legs].first[:maneuvers].last[:startPoint][:lat]
      @lng = data[:route][:legs].first[:maneuvers].last[:startPoint][:lng]
    else
      @lat = nil
      @lng = nil
    end
    if data[:route][:formattedTime]
      @travel_time = data[:route][:formattedTime]
    else
      @travel_time = "impossible route"
    end
    @weather_at_eta = {:datetime => nil, :temperature => nil, :condition => nil}
  end
end