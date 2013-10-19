class AddTableIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :table_id, :integer
  end
end
