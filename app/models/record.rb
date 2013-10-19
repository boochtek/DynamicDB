require 'json'

class Record < ActiveRecord::Base
  belongs_to :table

  # attribute :serialized_data, String

  def data
    JSON.parse(read_attribute(:serialized_data)) || []
  end
end
