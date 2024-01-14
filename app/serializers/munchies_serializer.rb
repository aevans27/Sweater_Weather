class MunchiesSerializer
  include JSONAPI::Serializer
  attributes :destination_city, :forecast, :restaurant
end