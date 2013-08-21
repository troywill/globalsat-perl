json.array!(@locations) do |location|
  json.extract! location, :time, :lat, :lon
  json.url location_url(location, format: :json)
end
