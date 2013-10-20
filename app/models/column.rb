class Column < ActiveRecord::Base
  belongs_to :table

  # attribute :name, String
  # attribute :data_type, String
  # timestamps

  default_scope order('created_at')

  # TYPES = [ "String", "Integer", "Decimal", "Date", "Boolean" ]
  TYPES = [ "String", "Integer", "Decimal", "Boolean" ]

  def type
    read_attribute(:data_type) || "String"
  end
end
