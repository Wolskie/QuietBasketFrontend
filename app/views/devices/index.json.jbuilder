json.array!(@devices) do |device|
  json.extract! device, :id, :name, :description
  json.url device_url(device, format: :json)
end
