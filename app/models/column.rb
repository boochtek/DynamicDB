class Column < ActiveRecord::Base
  belongs_to :table
  belongs_to :linked_column, class_name: "Column", inverse_of: :dependent_columns
  has_many :dependent_columns, class_name: "Column", inverse_of: :linked_column, foreign_key: :linked_column_id

  # attribute :name, String
  # attribute :data_type, String
  # timestamps

  default_scope order('created_at')

  # TYPES = [ "String", "Integer", "Decimal", "Date", "Boolean" ]
  TYPES = [ "String", "Integer", "Decimal", "Boolean", "Link" ]

  def type
    read_attribute(:data_type) || "String"
  end
end
