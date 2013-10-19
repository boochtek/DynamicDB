json.array!(@databases) do |database|
  json.extract! database, :name
  json.url database_url(database, format: :json)
end
