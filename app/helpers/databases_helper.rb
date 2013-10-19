module DatabasesHelper
  def current_table
    @database.tables.first
  end
end
