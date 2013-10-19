class Table < ActiveRecord::Base
  belongs_to :database

  has_many :columns
  has_many :records

  def name
    read_attribute(:name) || 'New Table'
  end
end
