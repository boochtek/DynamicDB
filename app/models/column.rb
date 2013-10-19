class Column < ActiveRecord::Base
  belongs_to :table

  def type
    read_attribute(:type) || "String"
  end
end
