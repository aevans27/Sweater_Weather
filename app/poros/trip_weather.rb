class TripWeather
  attr_reader :id, :type, :hourly_weather
  def initialize(data, day, hour)
    @id = data[:nothing]
    @type = "forecast"
    @hourly_weather = []
    data[:forecast][:forecastday].last[:hour].each do |cast|
      hour = {
        :time => cast[:time],
        :temperature => cast[:temp_f],
        :conditions => cast[:condition][:text]
      }
      @hourly_weather << hour
    end
  end
end