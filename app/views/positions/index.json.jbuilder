json.array!(@positions) do |position|
  json.extract! position, :id, :latitude, :longitude, :device_id
  json.url position_url(position, format: :json)
end
