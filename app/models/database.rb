class Database < ActiveRecord::Base
  has_many :tables

  def name
    read_attribute(:name) || 'New Database'
  end
end
