class AddLinkedColumnIdToColumn < ActiveRecord::Migration
  def change
    add_column :columns, :linked_column_id, :integer
  end
end
