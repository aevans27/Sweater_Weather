class Munchies
  attr_reader :id, :type, :destination_city, :forecast, :restaurant, :lat, :lng
  def initialize(data)
    @id = data[:nothing]
    @type = "munchie"
    @destination_city = "#{data[:businesses].first[:location][:city]}, #{data[:businesses].first[:location][:state]}"
    @forecast = {:summary => nil, :temperature => nil}
    @restaurant = {
      :name => data[:businesses].first[:name],
      :address => "#{data[:businesses].first[:location][:display_address].first}, #{data[:businesses].first[:location][:display_address].last}",
      :rating => data[:businesses].first[:rating],
      :reviews => data[:businesses].first[:review_count]
    }
    @lat = data[:businesses].first[:coordinates][:latitude]
    @lng = data[:businesses].first[:coordinates][:longitude]
  end
end
# {
#   "data": {
#     "id": "null",
#     "type": "munchie",
#     "attributes": {
#       "destination_city": "Pueblo, CO",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "83"
#       },
#       "restaurant": {
#         "name": "La Forchetta Da Massi",
#         "address": "126 S Union Ave, Pueblo, CO 81003",
#         "rating": 4.5,
#         "reviews": 148
#       }
#     }
#   }
# }