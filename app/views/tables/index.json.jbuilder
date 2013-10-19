json.array!(@tables) do |table|
  json.extract! table, :name, :database_id
  json.url table_url(table, format: :json)
end
