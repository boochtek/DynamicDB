class Database < ActiveRecord::Base
  def name
    read_attribute(:name) || 'New Database'
  end
end
