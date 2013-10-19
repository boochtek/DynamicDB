require 'json'

class Record < ActiveRecord::Base
  belongs_to :table

  # attribute :serialized_data, String

  def data
    JSON.parse(read_attribute(:serialized_data)) rescue []
  end

  def update(options)
    new_data = data.dup
    new_data[Integer(options[:index])] = options[:value]
    update_attribute(:serialized_data, JSON.unparse(new_data))
  end
end
