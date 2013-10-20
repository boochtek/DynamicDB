class Column < ActiveRecord::Base
  belongs_to :table

  default_scope order('created_at')

  def type
    read_attribute(:data_type) || "String"
  end
end
