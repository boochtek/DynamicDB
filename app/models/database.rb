class Database < ActiveRecord::Base
  has_many :tables

  # attribute :name, String
  # timestamps

  def initialize()
    super
    tables << Table.new(database_id: id)
  end

  def name
    read_attribute(:name) || 'New Database'
  end
end
