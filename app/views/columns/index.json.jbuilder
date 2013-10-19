json.array!(@columns) do |column|
  json.extract! column, :name, :table_id
  json.url column_url(column, format: :json)
end
