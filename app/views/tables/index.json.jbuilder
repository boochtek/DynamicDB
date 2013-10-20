json.array!(@tables) do |table|
  json.extract! table, :id, :name, :database_id
  json.url table_url(table, format: :json)
end
