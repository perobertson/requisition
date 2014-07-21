json.array!(@ships) do |ship|
  json.extract! ship, :id
  json.url ship_url(ship, format: :json)
end
