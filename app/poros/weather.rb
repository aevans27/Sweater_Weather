class Weather
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather
  def initialize(data)
    @id = data[:nothing]
    @type = "forecast"
    @current_weather = {
      :last_updated => data[:current][:last_updated],
      :temperature => data[:current][:temp_f],
      :feels_like => data[:current][:feelslike_f],
      :humidity => data[:current][:humidity],
      :uvi => data[:current][:uv],
      :visibility => data[:current][:vis_miles],
      :condition => data[:current][:condition][:text],
      :icon => data[:current][:condition][:icon]
    }
    @daily_weather = []
    data[:forecast][:forecastday].each do |fore|
      day = {
        :date => fore[:date],
        :sunrise => fore[:astro][:sunrise],
        :sunset => fore[:astro][:sunset],
        :max_temp => fore[:day][:maxtemp_f],
        :min_temp => fore[:day][:mintemp_f],
        :condition => fore[:day][:condition][:text],
        :icon => fore[:day][:condition][:icon]
      }
      @daily_weather << day
    end
    @hourly_weather = []
    data[:forecast][:forecastday].first[:hour].each do |cast|
      hour = {
        :time => cast[:time].split.last,
        :temperature => cast[:temp_f],
        :conditions => cast[:condition][:text],
        :icon => cast[:condition][:icon]
      }
      @hourly_weather << hour
    end
  end
end