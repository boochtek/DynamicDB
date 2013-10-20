require 'json'

class Record < ActiveRecord::Base
  belongs_to :table

  # attribute :serialized_data, String
  # timestamps

  default_scope order('created_at')

  def data
    JSON.parse(read_attribute(:serialized_data)) rescue []
  end

  def update(options)
    if options.has_key?(:all_values)
      new_data = options[:all_values]
    elsif options.has_key?(:index) && options.has_key?(:value)
      new_data = data.dup
      new_data[Integer(options[:index])] = options[:value]
    end
    update_attribute(:serialized_data, JSON.unparse(new_data))
  end
end
