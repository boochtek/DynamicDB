class Column < ActiveRecord::Base
  belongs_to :table

  def type
    read_attribute(:data_type) || "String"
  end
end
